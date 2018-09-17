<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use ZipArchive;
use Exception;
use File;

class SuplistController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $sponsors = DB::table('sponsor')->orderBy('name_Sponsor', 'ASC')->get();
        return response()->json([
            'sponsors'    => $sponsors
        ], 200);
    }

    public function getOffers(Request $request)
    {
        $offers = DB::table('offer')
                ->where('id_Sponsor_Offer', '=', $request->id_Sponsor_Offer)
                ->orderBy('name_Offer', 'ASC')->get();
        return response()->json([
            'offers'    => $offers
        ], 200);
    }

    public function cURL_Download($fileUrl, $filelocal)
    {   
        $ch = curl_init($fileUrl);
		curl_setopt($ch, CURLOPT_FILE, $filelocal);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
		curl_exec($ch);
        if(curl_errno($ch))
		{
            throw new Exception(curl_error($ch));
		}
		$statusCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        return $statusCode;
    }

    public function renameSuplist($path, $dir, $id_offer, $md5_list)
    {
        foreach(glob($dir . "*.*") as $file)
        {
            if(!is_dir($file))
            { 
                if(strpos($file, "domains_list--") == 0)
                {
                    $offer = DB::table('offer')
                            ->where('id_offer', '=', $id_offer)
                            ->first();
                    $supp_fine_name	=	'/home/exactarget/offers/suppression/sp' . $offer->id_Sponsor_Offer . '-' . $offer->id_offer . '-' . $offer->sid_Offer . '-MD5.txt';
                    if($md5_list == "No")
                    {
                        $base_file = basename($file);
                        $array_file_name = (explode(".",$base_file));
                        $target_file = $array_file_name[0] . "_textToMD5_Updated.txt";
                        $this->textToMD5($dir . $base_file, $dir . $target_file);
                        rename($dir . $target_file, $supp_fine_name);
                    }
                    else if($md5_list == "Yes")
                    {
                        rename($file, $supp_fine_name);
                    }
                    DB::table('offer')
                        ->where('id_offer', '=', $id_offer)
                        ->update(['suppressionFile_Offer' => 'sp' . $offer->id_Sponsor_Offer . '-' . $offer->id_offer . '-' . $offer->sid_Offer . '-MD5.txt', 'TypeSuppressionFile_Offer' => 'MD5']);
                }
            }
        }
        $this->deleteDirectory($path);
    }

    public function deleteDirectory($dir) {
        exec("rm -rf " . $dir);
    }

    public function textToMD5($p_source_file, $p_target_file)
    {
        $textFile = fopen($p_source_file, 'r') or die("Unable to open file!");
        $md5File = fopen($p_target_file, 'a+') or die("Unable to open file!");
		while(!feof($textFile)) 
		{
			$email = fgets($textFile);
			$email = trim(preg_replace('/\s+/', ' ', $email));
			$md5_email = md5($email) . PHP_EOL;
			fwrite($md5File, $md5_email);
		}	
		fclose($textFile);
        fclose($md5File);
        unlink($p_source_file);
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
        set_time_limit(0);
        ini_set("memory_limit","2048M");
        ini_set("upload_max_filesize","3000M");
        ini_set("post_max_size","3000M");
        ini_set("max_execution_time","0");
        ini_set("max_input_time","0");
        ini_set('display_errors', 1);
        ini_set('display_startup_errors', 1);
        error_reporting(E_ALL);

        $fileUrl  = $request->url;
        $id_offer = $request->offers;
        $md5_list = $request->md5;
        $format_file_url  = $request->format_file_url;
        $path = public_path('/TempDirSup/');
		if(!is_dir($path))
		{
			mkdir($path, 0777, true);
			chmod($path, 0777);
        }
        if($format_file_url == "Compressed")
        {
		    $saveTo = $path . '/suplist.zip';
        }
        else if($format_file_url == "TXT")
        {
            $dir = $path . "/suplist_extract/";
            if(!is_dir($dir))
            {
                mkdir($dir, 0777, true);
                chmod($dir, 0777);
            }
		    $saveTo = $dir . '/suplist.txt';
        }
		$filelocal = fopen($saveTo, 'w+');
		if($filelocal === false)
		{
            return response()->json([
                'msg' => 'Could not open: ' . $saveTo
            ], 500);
        }
        $statusCode = $this->cURL_Download($fileUrl, $filelocal);
        if($statusCode == 200)
        {
            if($format_file_url == "Compressed")
            {
                $zip = new ZipArchive;
                if ($zip->open($path . '/suplist.zip') === TRUE)
                {
                    $zip->extractTo($path . '/suplist_extract');
                    if($zip->close())
                    {
                        $dir = $path . "/suplist_extract/";
                        $this->renameSuplist($path, $dir, $id_offer, $md5_list);
                        return response()->json([
                                'msg'    => 'Your suppression file was uploaded and updated successfully !'
                            ], 200);
                    }
                    else
                    {
                        return response()->json([
                            'ZIP' => 'The Zip file does not closed successfully !'
                        ], 500);
                    }
                }
            }
            else if($format_file_url == "TXT")
            {
                fclose($filelocal);
                $this->renameSuplist($path, $dir, $id_offer, $md5_list);
                return response()->json([
                    'msg'    => 'Your suppression file was uploaded and updated successfully !'
                ], 200);
            }
        }
        else
        {
            return response()->json([
                'status' => 'Error cURL Download Status Code : ' + $statusCode
            ], $statusCode);
        }
    }

    public function suplist_upload(Request $request)
    {
        set_time_limit(0);
        ini_set("memory_limit","2048M");
        ini_set("upload_max_filesize","3000M");
        ini_set("post_max_size","3000M");
        ini_set("max_execution_time","0");
        ini_set("max_input_time","0");
        ini_set('display_errors', 1);
        ini_set('display_startup_errors', 1);
        error_reporting(E_ALL);

        $suplist_zip = $request->file('selectedFile');
        $id_offer = $request->offers;
        $md5_list = $request->md5;

        if(File::isFile($suplist_zip))
        {
            $path = public_path('/TempDirSup/');
            if(!is_dir($path))
            {
                mkdir($path, 0777, true);
                chmod($path, 0777);
            }
            if($suplist_zip->getClientOriginalExtension() == "gtar" || $suplist_zip->getClientOriginalExtension() == "gz" || $suplist_zip->getClientOriginalExtension() == "tar" || $suplist_zip->getClientOriginalExtension() == "zip" || $suplist_zip->getClientOriginalExtension() == "rar")
            {
                $nom_suplist_zip = "suplist.zip";
                $suplist_zip->move($path, $nom_suplist_zip);

                $zip = new ZipArchive;
                if ($zip->open($path . '/suplist.zip') === TRUE)
                {
                    $zip->extractTo($path . '/suplist_extract');
                    if($zip->close())
                    {
                        $dir = $path . "/suplist_extract/";
                        $this->renameSuplist($path, $dir, $id_offer, $md5_list);
                        return response()->json([
                                'msg'    => 'Your suppression file was uploaded and updated successfully !'
                            ], 200);
                    }
                    else
                    {
                        return response()->json([
                            'ZIP' => 'The Zip file does not closed successfully !'
                        ], 500);
                    }
                }
            }
            else if($suplist_zip->getClientOriginalExtension() == "txt")
            {
                $nom_suplist_zip = "suplist.txt";
                $dir = $path . "/suplist_extract/";
                if(!is_dir($dir))
                {
                    mkdir($dir, 0777, true);
                    chmod($dir, 0777);
                }
                $suplist_zip->move($dir, $nom_suplist_zip);
                $this->renameSuplist($path, $dir, $id_offer, $md5_list);
                return response()->json([
                    'msg'    => 'Your suppression file was uploaded and updated successfully !'
                ], 200);
            }
        }
        else
        {
            return response()->json([
                'msg' => 'The Supression file does not uploaded successfully !'
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
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
