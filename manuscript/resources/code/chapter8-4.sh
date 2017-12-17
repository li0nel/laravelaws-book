location ~ \.php$ {
   root /var/www/html/public;
   fastcgi_cache cache_key;
   fastcgi_cache_valid 200 204 1m;
   fastcgi_ignore_headers Cache-Control;
   fastcgi_no_cache $http_authorization $cookie_laravel_session;
   fastcgi_cache_lock on;
   fastcgi_cache_lock_timeout 10s;

   add_header X-Proxy-Cache $upstream_cache_status;

   sub_filter_types *;
   sub_filter_once off;
   sub_filter 'laravelaws-bucket-jjua0wgxhi7i.s3-ap-southeast-2.amazonaws.com' 'files.laravelaws.com';

   fastcgi_pass   app:9000;
   fastcgi_index  index.php;
   fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
   fastcgi_read_timeout 900s;
   include        fastcgi_params;
}
