<?php

use Illuminate\Database\Seeder;
//use Faker\Factory as Faker;
use App\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //$faker = Faker::create();
		User::create([
            'name' => 'ADMIN',
            'email' => 'admin@mail.com',
            'password' => bcrypt('123456')
        ]);
        /* foreach (range(1,5) as $index) {
            User::create([
                'name' => $faker->name,
                'email' => $faker->email,
                'password' => bcrypt('123456'),
            ]);
        } */
    }
}
