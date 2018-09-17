<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use phpseclib\Net\SFTP;
use phpseclib\Net\SSH2;
use ZipArchive;
use File;
use DB;

class ServerautomaticconfigurationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $servers = DB::table('server')->orderBy('alias_Server', 'ASC')->get();
        return response()->json([
            'servers' => $servers
        ], 200);
    }

    public function automatic_config_server (Request $request)
    {
        $server_id = $request->server_id;
        $dkim_file = $request->file('selectedFile');
        /* --------------------------- CONFIG PHP INI START --------------------------------- */
        set_time_limit(0);
        ini_set("memory_limit","2048M");
        ini_set("max_execution_time","0");
        ini_set("max_input_time","0");
        ini_set('display_errors', 1);
        ini_set('display_startup_errors', 1);
        error_reporting(E_ALL);
        /* --------------------------- CONFIG PHP INI START --------------------------------- */

        /* --------------------------- SERVER CONNECTION START --------------------------------- */
        $server = DB::table('server')->where('id_Server', '=', $server_id)->first();
        $main_ip = DB::table('ip')->where('id_IP', '=', $server->id_IP_Server)->first();
        $sftp = new SFTP($main_ip->IP_IP);
		if (!$sftp->login($server->username_Server, $server->password_Server)) {
            return response()->json([
                'msg' => 'SFTP Login Failed'
            ], 500);
		}
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            return response()->json([
                'msg' => 'SSH Login Failed'
            ], 500);
        }
        /* --------------------------- SERVER CONNECTION END --------------------------------- */

        /* --------------------------- CONSOLE SHOW ARRAY START --------------------------------- */
        $array_show_command = array();
        /* --------------------------- CONSOLE SHOW ARRAY END --------------------------------- */

        /* --------------------------- SELinux START --------------------------------- */
        // $show_command =   $ssh->exec("/usr/sbin/setsebool -P httpd_can_network_connect=1");
        // if($show_command == "setsebool:  SELinux is disabled.\n")
        // {
        //     $show_command =   $ssh->exec("truncate -s 0 /etc/selinux/config");
        //     $content_selinux_file = "SELINUX=permissive\n" . 
        //     "SELINUXTYPE=targeted\n";
        //     $show_command =   $ssh->exec('echo "' . $content_selinux_file . '" >> /etc/selinux/config');
        //     $show_command =   $ssh->exec("shutdown -r now");
        // }
        // $show_command =   $ssh->exec("/usr/sbin/setsebool -P httpd_can_network_connect=1");
        // $array_show_command[] = array('show_command' => $show_command);
        /* --------------------------- SELinux END --------------------------------- */

        /* --------------------------- IP ROTATION START --------------------------------- */
        $ifcfg_eth_number = 0;
        for($i = 0; $i < 5; $i++)
        {
            $show_command =   $ssh->exec("find /etc/sysconfig/network-scripts/ -type f -name 'ifcfg-eth" . $i . "'");
            if(isset($show_command) && !empty($show_command) && $show_command != "")
            {
                $ifcfg_eth_number = $i;
            }
        }
        $show_command =   $ssh->exec("find /etc/sysconfig/network-scripts/ -type f -name 'ifcfg-eth" . $ifcfg_eth_number . ":*'");
        if(empty($show_command) && $show_command == "")
        {
            $ips = DB::table('ip')->where("id_Server_IP", "=", $server->id_Server)->orderBy('id_IP', 'ASC')->get();
            if(count($ips) > 1)
            {
                for($i = 1; $i < count($ips); $i++)
                {
                    $show_command =   $ssh->exec("cp /etc/sysconfig/network-scripts/ifcfg-eth" . $ifcfg_eth_number . " /etc/sysconfig/network-scripts/ifcfg-eth" . $ifcfg_eth_number . ":" . ($i-1));
                    $show_command =   $ssh->exec("sed -i 's/.*DEVICE=.*/DEVICE=eth0:" . ($i-1) . "/' /etc/sysconfig/network-scripts/ifcfg-eth" . $ifcfg_eth_number . ":" . ($i-1));
                    $show_command =   $ssh->exec("sed -i 's/.*IPADDR=.*/IPADDR=" . $ips[$i]->IP_IP . "/' /etc/sysconfig/network-scripts/ifcfg-eth" . $ifcfg_eth_number . ":" . ($i-1));
                }
            }
            else
            {
                $array_show_command[] = array('show_command' => "This server has only one @IP address, so no need to configure IPs ROTATION !\n");
            }
        }
        else
        {
            $array_show_command[] = array('show_command' => "IP ROTATION Already Configured !\n");
        }
        /* --------------------------- IP ROTATION END --------------------------------- */

        /* --------------------------- Network HostName HTTPD Config START --------------------------------- */
        $server_name = strtolower($server->alias_Server);
        $server_name = preg_replace('/\s+/', '', $server_name);

        $main_domain = DB::table('domain')->where('id_Domain', '=', $main_ip->id_Domain_IP)->first();
        
        $show_command =   $ssh->exec("truncate -s 0 /etc/hosts");
        $content_hosts_file = "127.0.0.1\tlocalhost localhost.localdomain localhost4 localhost4.localdomain4\n" . 
        "::1\tlocalhost localhost.localdomain localhost6 localhost6.localdomain6\n" . 
        $main_ip->IP_IP . "\t" . $server_name . "." . $main_domain->name_Domain;
        $show_command =   $ssh->exec('echo "' . $content_hosts_file . '" >> /etc/hosts');

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("hostname " . $server_name . "." . $main_domain->name_Domain);
        $show_command =   $ssh->exec("hostname");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("sed -i 's/.*HOSTNAME=.*/HOSTNAME=" . $server_name . "." . $main_domain->name_Domain . "/' /etc/sysconfig/network");
        $show_command =   $ssh->exec("cat /etc/sysconfig/network");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("cat /etc/hosts");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("service network restart");
        $show_command =   $ssh->exec("service network restart");
        $array_show_command[] = array('show_command' => $show_command);
        /* --------------------------- Network HostName HTTPD Config END --------------------------------- */

        /* --------------------------- UPLOAD & TRANSFER DKIM START --------------------------------- */
         if(File::isFile($dkim_file))
        {
            if($dkim_file->getClientOriginalExtension() == "txt")
            {
                $path = public_path('/config_files/');
                $dir = $path . "/etc/pmta/domainKeys/";
                if(!is_dir($dir))
                {
                    mkdir($dir, 0777, true);
                    chmod($dir, 0777);
                }
                $nom_dkim_file = "SELECTOR1." . $main_domain->name_Domain . ".pem";
                $dkim_file->move($dir, $nom_dkim_file);
            }
            else
            {
                return response()->json([
                    'msg' => 'The extension is not txt, please upload a file with txt extension !'
                ], 500);
            }
        }
        else
        {
            return response()->json([
                'msg' => 'The DKIM file does not uploaded successfully !'
            ], 500);
        }
        /* --------------------------- UPLOAD & TRANSFER DKIM END --------------------------------- */

        /* --------------------------- CONFIG DATE & TIME START --------------------------------- */
        $show_command =   $ssh->exec("echo 'export VISUAL=\"nano\"' >> ~/.bash_profile");
        $show_command =   $ssh->exec("echo 'export EDITOR=\"nano\"' >> ~/.bash_profile");
        $show_command =   $ssh->exec("echo 'ZONE=\"Africa/Casablanca\"' > /etc/sysconfig/clock");
        $show_command =   $ssh->exec("echo 'UTC=true' >> /etc/sysconfig/clock");

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("ln -snf /usr/share/zoneinfo/Africa/Casablanca /etc/localtime");
        $show_command =   $ssh->exec("yum -y install ntp.x86_64|tee -a /tmp/install_log");
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("ntpd -g -q");
        $array_show_command[] = array('show_command' => $show_command);
        /* --------------------------- CONFIG DATE & TIME END --------------------------------- */
        
        /* --------------------------- UPDATE & INSTALL SOFTWARE START --------------------------------- */
        /* $show_command =   $ssh->exec("yum -y update|tee -a /tmp/update_log");
        $array_show_command[] = array('show_command' => $show_command); */

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        
        $show_command =   $ssh->exec("yum -y install mod_ssl.x86_64|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install openssh-clients rsync|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install gcc.x86_64|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install dos2unix.x86_64|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install sudo.x86_64 wget.x86_64|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
		

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
		
        $show_command =   $ssh->exec("yum -y install perl-ExtUtils-MakeMaker.x86_64 |tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install cronie.x86_64 cronie-anacron.x86_64  crontabs.noarch|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install iptraf.x86_64|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install nano.x86_64 telnet.x86_64 sudo.x86_64 lsof.x86_64 |tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install httpd.x86_64|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        /* $show_command =   $ssh->exec("service httpd start");
        $array_show_command[] = array('show_command' => $show_command); */ 
        
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install php php-cli php-gd php-mysql php-mbstring|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install gcc php-devel php-pear libssh2 libssh2-devel make php-devel php-pearlibssh2-devel|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install php-imap |tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install libssh2-php|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install net-tools|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("printf \"\n\" | pecl install -f ssh2");
        $array_show_command[] = array('show_command' => $show_command);

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        
        $show_command =   $ssh->exec("echo extension=ssh2.so > /etc/php.d/ssh2.ini");

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        /* $show_command =   $ssh->exec("service httpd restart");
        $array_show_command[] = array('show_command' => $show_command); */
        $show_command =   $ssh->exec("yum -y install zip unzip|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $show_command =   $ssh->exec("yum -y install iptables|tee -a /tmp/install_log");
        $array_show_command[] = array('show_command' => $show_command);
        /* --------------------------- UPDATE & INSTALL SOFTWARE END --------------------------------- */

        /* --------------------------- SCP FILES SERVER 2 SERVER START --------------------------------- */
        $sftp->put('/home/PowerMTA-4.0r6-201204021809.x86_64.rpm', public_path('/config_files/') . '/PowerMTA-4.0r6-201204021809.x86_64.rpm', SFTP::SOURCE_LOCAL_FILE);
        $sftp->put('/home/license', public_path('/config_files/') . '/license', SFTP::SOURCE_LOCAL_FILE);
        $sftp->put('/home/license', public_path('/config_files/') . '/license', SFTP::SOURCE_LOCAL_FILE);
        $show_command =   $ssh->exec("rm -f /etc/php.ini");
        $sftp->put('/etc/php.ini', public_path('/config_files/') . '/etc/php.ini', SFTP::SOURCE_LOCAL_FILE);
        $show_command =   $ssh->exec("rm -f /etc/sudoers");
        $sftp->put('/etc/sudoers', public_path('/config_files/') . '/etc/sudoers', SFTP::SOURCE_LOCAL_FILE);
        $sftp->put('/var/www/Creatives.zip', public_path('/config_files/') . '/Creatives.zip', SFTP::SOURCE_LOCAL_FILE);
        $sftp->put('/var/www/RDT.zip', public_path('/config_files/') . '/RDT.zip', SFTP::SOURCE_LOCAL_FILE);
        $show_command =   $ssh->exec("unzip /var/www/Creatives.zip -d \"/var/www\"");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("unzip /var/www/RDT.zip -d \"/var/www\"");
        $array_show_command[] = array('show_command' => $show_command);

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        /* --------------------------- REPLACE VALUE CONNECTION DB APP START --------------------------------- */
        $info_connection_db_file = fopen(public_path('/config_files/') . '/info_connection_db.txt', 'r');
        $connection_array = explode(";", fgets($info_connection_db_file));
        fclose($info_connection_db_file);
        $this->copy_directory(public_path('/config_files/') . '/exactarget', public_path('/config_files/') . '/exactarget_mod');
        $info_connection_db = file_get_contents(public_path('/config_files/') . '/exactarget_mod/includes/bdd.php');
        $info_connection_db = str_replace("**ip_address**", $connection_array[0], $info_connection_db);
        $info_connection_db = str_replace("**db_name**", $connection_array[1], $info_connection_db);
        $info_connection_db = str_replace("**db_user**", $connection_array[2], $info_connection_db);
        $info_connection_db = str_replace("**db_password**", $connection_array[3], $info_connection_db);
        file_put_contents(public_path('/config_files/') . '/exactarget_mod/includes/bdd.php', $info_connection_db);
        $array_show_command[] = array('show_command' => "The Database connection information has been updated successfully !\n");
        /* --------------------------- REPLACE VALUE CONNECTION DB APP END --------------------------------- */

        $show_command =   $ssh->exec("chmod -R 777 /var/www/Creatives /var/www/RDT");
        $show_command =   $ssh->exec("chown -R apache:apache /var/www/Creatives");
        $show_command =   $ssh->exec("chown -R apache:apache /var/www/RDT");
        $show_command =   $ssh->exec("rm -f /var/www/Creatives.zip");
        $show_command =   $ssh->exec("rm -f /var/www/RDT.zip");
        $show_command =   $ssh->exec("rm -f /var/www/update_info_connection_db.php");
        /* --------------------------- SCP FILES SERVER 2 SERVER END --------------------------------- */

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        /* --------------------------- CONFIG HTTPD START --------------------------------- */
        $show_command =   $ssh->exec("rm -f /etc/httpd/conf/httpd.conf");
        copy(public_path('/config_files/') . '/httpd.conf', public_path('/config_files/') . '/httpd_mod.conf');
        $httpd_conf = file_get_contents(public_path('/config_files/') . '/httpd_mod.conf');
        $httpd_conf = str_replace("**ip_master**", $_SERVER['SERVER_ADDR'], $httpd_conf);
        $httpd_conf = str_replace("**ip_small**", $main_ip->IP_IP, $httpd_conf);
        file_put_contents(public_path('/config_files/') . '/httpd_mod.conf', $httpd_conf);
        $array_show_command[] = array('show_command' => "The httpd.conf file has been updated successfully !\n");
        $sftp->put('/etc/httpd/conf/httpd.conf', public_path('/config_files/') . '/httpd_mod.conf', SFTP::SOURCE_LOCAL_FILE);
        unlink(public_path('/config_files/') . '/httpd_mod.conf');
        /* --------------------------- CONFIG HTTPD END --------------------------------- */

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        /* --------------------------- CONFIG IPTABLES START --------------------------------- */
        $show_command =   $ssh->exec("iptables -A INPUT -p tcp --dport 22 -j ACCEPT");
        $show_command =   $ssh->exec("iptables -I INPUT -p tcp --dport 25 -j ACCEPT");
        $show_command =   $ssh->exec("iptables -I INPUT -p tcp --dport 2500 -j ACCEPT");
        $show_command =   $ssh->exec("iptables -I INPUT -p tcp --dport 80 -j ACCEPT");
        $show_command =   $ssh->exec("iptables -I INPUT -p tcp --dport 2304 -j ACCEPT");
        $show_command =   $ssh->exec("iptables -I INPUT -p tcp --dport 21 -j ACCEPT");
        $show_command =   $ssh->exec("chkconfig iptables on");
        $show_command =   $ssh->exec("service iptables save");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("service iptables restart");
        $array_show_command[] = array('show_command' => $show_command);
        /* $show_command =   $ssh->exec("service httpd restart");
        $array_show_command[] = array('show_command' => $show_command); */
        /* --------------------------- CONFIG IPTABLES END --------------------------------- */

        /* --------------------------- INSTALL & CONFIG PMTA START --------------------------------- */
        $show_command =   $ssh->exec("rpm -ivh /home/PowerMTA-4.0r6-201204021809.x86_64.rpm");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("cp /home/license /etc/pmta/license");

        /* --------------------------- CONFIG PMTA APP START --------------------------------- */
        $hostname_server = "host-name " . $server_name . "." . $main_domain->name_Domain;
        $relay_domain = "";
        $smtp_listener = "";
        $source_small = "";
        $source_master = "";
        $vmtas = "";
        foreach($ips as $ip)
        {
            $relay_domain_table = DB::table('domain')->where('id_Domain', '=', $ip->id_Domain_IP)->first();
            $relay_domain .= "relay-domain " . $relay_domain_table->name_Domain . "\n"; 
            $smtp_listener .= "smtp-listener " . $ip->IP_IP . ":25\n";
            $source_small .= "#_____LOCAL___________\n<source " . $ip->IP_IP . ">\n\talways-allow-relaying yes\n\tsmtp-service yes\n\tlog-connections no\n\tlog-commands no\n\tprocess-x-envid true\n\tprocess-x-job true\n\tprocess-x-virtual-mta yes\n\tadd-received-header no\n\tallow-mailmerge true\n</source>\n";
            $vmtas .= "<virtual-mta mta-" . $ip->IP_IP . ">\n\tsmtp-source-ip " . $ip->IP_IP . "\n\thost-name " . $relay_domain_table->name_Domain . "\n\tdomain-key SELECTOR1, " . $relay_domain_table->name_Domain . ", /etc/pmta/domainKeys/SELECTOR1." . $relay_domain_table->name_Domain . ".pem\n</virtual-mta>\n";
        }
        $source_master = "#_____CENTRAL___________\n<source " . $_SERVER['SERVER_ADDR'] . ">\n\talways-allow-relaying yes\n\tsmtp-service yes\n\tlog-connections no\n\tlog-commands no\n\tprocess-x-envid true\n\tprocess-x-job true\n\tprocess-x-virtual-mta yes\n\tadd-received-header no\n\tallow-mailmerge true\n</source>\n";

        /* ------------ Update hostName Config PMTA START ------------ */
        $info_hostname = file_get_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/hostName.txt');
        $info_hostname = str_replace("**hostname_server**", $hostname_server, $info_hostname);
        file_put_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/hostName.txt', $info_hostname);
        /* ------------ Update hostName Config PMTA END ------------ */

        /* ------------ Update relayDomain Config PMTA START ------------ */
        $info_relay_domain = file_get_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/relayDomain.txt');
        $info_relay_domain = str_replace("**relay_domain**", $relay_domain, $info_relay_domain);
        file_put_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/relayDomain.txt', $info_relay_domain);
        /* ------------ Update relayDomain Config PMTA END ------------ */

        /* ------------ Update smtpListener Config PMTA START ------------ */
        $info_smtp_listener = file_get_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/smtpListener.txt');
        $info_smtp_listener = str_replace("**smtp_listener**", $smtp_listener, $info_smtp_listener);
        file_put_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/smtpListener.txt', $info_smtp_listener);
        /* ------------ Update smtpListener Config PMTA END ------------ */

        /* ------------ Update Source Master + Small Config PMTA START ------------ */
        $info_source = file_get_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/source.txt');
        $info_source = str_replace("**source_small**", $source_small, $info_source);
	    $info_source = str_replace("**source_master**", $source_master, $info_source);
        file_put_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/source.txt', $info_source);
        /* ------------ Update Source Master + Small Config PMTA END ------------ */

        /* ------------ Update vmtas Config PMTA START ------------ */
        $info_vmta = file_get_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/vmta.txt');
        $info_vmta = str_replace("**vmtas**", $vmtas, $info_vmta);
        file_put_contents(public_path('/config_files/') . '/exactarget_mod/PMTA/vmta.txt', $info_vmta);
        /* ------------ Update vmtas Config PMTA END ------------ */
        $array_show_command[] = array('show_command' => "The PMTA Configuration information has been updated successfully !\n");
        $real_path_config = realpath(public_path('/config_files/'));
        chdir($real_path_config);
        if (substr(php_uname(), 0, 7) == "Windows"){
            try {
                exec("./7-Zip64/7z.exe a exactarget.zip exactarget_mod");
            } catch (Exception $e) {
                return response()->json([
                    'Error Exception ZIP WINDOWS => ' => $e->getMessage()
                ], 500);
            }
        }
        else {
			$output_zip_compress = shell_exec('zip -r exactarget.zip exactarget_mod/'); 
			$array_show_command[] = array('show_command' => $output_zip_compress);
        } 
        $sftp->put('/var/www/exactarget.zip', public_path('/config_files/') . '/exactarget.zip', SFTP::SOURCE_LOCAL_FILE);
        $show_command =   $ssh->exec("unzip /var/www/exactarget.zip -d \"/var/www\"");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("mv /var/www/exactarget_mod /var/www/exactarget");
        $show_command =   $ssh->exec("chmod -R 777 /var/www/exactarget");
        $show_command =   $ssh->exec("chown -R apache:apache /var/www/exactarget");
        $show_command =   $ssh->exec("rm -f /var/www/exactarget.zip");
        unlink(public_path('/config_files/') . '/exactarget.zip');
        $this->rrmdir(public_path('/config_files/') . '/exactarget_mod');
        /* --------------------------- CONFIG PMTA APP START --------------------------------- */

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        $sftp->put('/etc/pmta/config', public_path('/config_files/') . '/etc/pmta/config', SFTP::SOURCE_LOCAL_FILE);
        $show_command =   $ssh->exec("mkdir -p /etc/pmta/domainKeys");
        $sftp->put('/etc/pmta/domainKeys/' . $nom_dkim_file, public_path('/config_files/') . '/etc/pmta/domainKeys/' . $nom_dkim_file, SFTP::SOURCE_LOCAL_FILE);
        $show_command =   $ssh->exec("chmod -R 777 /etc/pmta/domainKeys");
        unlink(public_path('/config_files/') . '/etc/pmta/domainKeys/' . $nom_dkim_file);

        $show_command =   $ssh->exec("chown pmta:pmta /etc/pmta/config");
        $show_command =   $ssh->exec("chmod 777 /etc/pmta/config");
        $show_command =   $ssh->exec("mkdir -p /var/spool/pmtaPickup/");
        $show_command =   $ssh->exec("mkdir -p /var/spool/pmtaPickup/Pickup");
        $show_command =   $ssh->exec("mkdir -p /var/spool/pmtaPickup/BadMail");
        $show_command =   $ssh->exec("mkdir -p /var/spool/pmtaIncoming");
        $show_command =   $ssh->exec("chown pmta:pmta /var/spool/pmtaIncoming");
        $show_command =   $ssh->exec("chmod 777 /var/spool/pmtaIncoming");
        $show_command =   $ssh->exec("chown pmta:pmta /var/spool/pmtaPickup/*");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmta");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmtaAccRep");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmtaErr");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmtaErrRep");

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
		
        $show_command =   $ssh->exec("chown pmta:pmta  /var/log/pmta");
        $show_command =   $ssh->exec("chown pmta:pmta  /var/log/pmtaAccRep");
        $show_command =   $ssh->exec("chown pmta:pmta  /var/log/pmtaErr");
        $show_command =   $ssh->exec("chown pmta:pmta /var/log/pmtaErrRep");
        $show_command =   $ssh->exec("chmod 777 /var/log/pmta");
        $show_command =   $ssh->exec("chmod 777 /var/log/pmtaAccRep");
        $show_command =   $ssh->exec("chmod 777 /var/log/pmtaErr");
        $show_command =   $ssh->exec("chmod 777 /var/log/pmtaErrRep");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmta/pmta-bounce");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmta/pmta-deliver");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmta/pmta-soft");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmta/pmta-bounce");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmta/pmta-deliver");
        $show_command =   $ssh->exec("mkdir -p /var/log/pmta/pmta-soft");
        /* --------------------------- INSTALL & CONFIG PMTA END --------------------------------- */

        /* --------------------------- CRON JOB START --------------------------------- */
        $show_command =   $ssh->exec('echo "10 0 * * * rm -f /var/log/pmta/log-*" | tee -a /var/spool/cron/root 2>&1');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('echo "*/30 * * * * /usr/bin/php /var/www/exactarget/Send/received.php" | tee -a /var/spool/cron/root 2>&1');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('echo "*/30 * * * * /usr/bin/php /var/www/exactarget/Send/delivered.php" | tee -a /var/spool/cron/root 2>&1');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('echo "*/30 * * * * /usr/bin/php /var/www/exactarget/Send/bounce.php" | tee -a /var/spool/cron/root 2>&1');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('service crond restart');
        $array_show_command[] = array('show_command' => $show_command);
        /* --------------------------- CRON JOB END --------------------------------- */

        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
        /* --------------------------- DISCONNECT AND RECONNECT START --------------------------------- */

        /* --------------------------- START HTTPD & PMTA START --------------------------------- */
        $show_command =   $ssh->exec('service pmta reload');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec("service httpd start");
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('service httpd restart');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('service pmta restart');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('service pmtahttp restart');
        $array_show_command[] = array('show_command' => $show_command);
        $show_command =   $ssh->exec('chkconfig iptables on');
        $show_command =   $ssh->exec('chkconfig httpd on');
        $show_command =   $ssh->exec('chkconfig pmta on');
        $show_command =   $ssh->exec('chkconfig pmtahttp on');
        /* --------------------------- START HTTPD & PMTA END --------------------------------- */

        return response()->json([
            'array_show_command' => $array_show_command,
            'entete_commande' => '[' . $server->username_Server . '@' . $server_name . "." . $main_domain->name_Domain . ']#'
        ], 200);
    }

    public function rrmdir($dir) { 
        if (is_dir($dir)) { 
            $objects = scandir($dir); 
            foreach ($objects as $object) { 
            if ($object != "." && $object != "..") { 
                if (is_dir($dir."/".$object))
                self::rrmdir($dir."/".$object);
                else
                unlink($dir."/".$object); 
            } 
            }
            rmdir($dir); 
        } 
    }

    public function zip_directory($source, $zip, $folder_name)
    {
        $source = realpath($source);
        if (is_string($source)) $source_arr = array($source);
        foreach ($source_arr as $source)
        {
            if (!file_exists($source)) continue;
            $source = str_replace('\\', '/', realpath($source));
            if (is_dir($source) === true)
            {
                $files = new \RecursiveIteratorIterator(new \RecursiveDirectoryIterator($source), \RecursiveIteratorIterator::SELF_FIRST);

                foreach ($files as $file)
                {
                    $file = str_replace('\\', '/', realpath($file));
                    if (is_dir($file) === true)
                    {
                        $zip->addEmptyDir(str_replace($source . '/', '', $folder_name . $file . '/'));
                    }
                    else if (is_file($file) === true)
                    {
                        $zip->addFromString(str_replace($source . '/', '', $folder_name . $file), file_get_contents($file));
                    }
                }
            }
            else if (is_file($source) === true)
            {
                $zip->addFromString(basename($source), file_get_contents($source));
            }

        }
    }

    public function copy_directory($source, $dest) { 
        mkdir($dest, 0777);
        foreach(
            $iterator = new \RecursiveIteratorIterator(
                new \RecursiveDirectoryIterator($source, \RecursiveDirectoryIterator::SKIP_DOTS), \RecursiveIteratorIterator::SELF_FIRST) as $item) 
        {
            if ($item->isDir()) 
            {
                mkdir($dest . DIRECTORY_SEPARATOR . $iterator->getSubPathName());
            } 
            else 
            {
                copy($item, $dest . DIRECTORY_SEPARATOR . $iterator->getSubPathName());
            }
        }
    } 

    public function disconnect_reconnect($ssh, $main_ip, $server)
    {
        unset($ssh); 
        $ssh = new SSH2($main_ip->IP_IP);
        if (!$ssh->login($server->username_Server, $server->password_Server)) {
            exit('Login Failed');
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id_Server
     * @return \Illuminate\Http\Response
     */
    public function show($id_Server)
    {
        $data = DB::table('ip')->where('server.id_Server', '=', $id_Server)
        ->join('server', 'ip.id_Server_IP', '=', 'server.id_Server')
        ->join('domain', 'ip.id_Domain_IP', '=', 'domain.id_Domain')
        ->select('ip.*', 'server.*', 'domain.*')
        ->orderBy('ip.id_Server_IP', 'ASC')
        ->get();
        return response()->json([
            'data'    => $data
        ], 200);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
