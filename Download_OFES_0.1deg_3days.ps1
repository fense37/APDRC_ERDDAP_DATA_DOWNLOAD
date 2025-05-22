# download ssh, u, v, w, s, t ofes output data from apdrc website
# Created by Wang Zhuoyue at 2024/9/30

# download filepath
$filepath = "E:\Data\OFES\ENP\"

# download starttime (use unix timestamp)
# start from 1990-01-01
$starttime = 631152000

# download region range
$minlon = 200
$maxlon = 250
$minlat = 10
$maxlat = 30 
$mindep = 0
$maxdep = 1000

$client = new-object System.Net.WebClient

for($year=1990;$year -le 2020;$year++)
{
	$yy="{0:D4}" -f $year
	echo $yy
	try{
		mkdir $filepath
		mkdir $filepath"\s"
		mkdir $filepath"\ssh"
		mkdir $filepath"\t"
		mkdir $filepath"\u"
		mkdir $filepath"\v"
		mkdir $filepath"\w"
		mkdir $filepath"\s\"$yy
		mkdir $filepath"\ssh\"$yy
		mkdir $filepath"\t\"$yy
		mkdir $filepath"\u\"$yy
		mkdir $filepath"\v\"$yy
		mkdir $filepath"\w\"$yy
	}
	catch{}
	for($mon=1;$mon -le 12;$mon++)   
	{
		$mm="{0:D2}" -f $mon
        		echo $mm
		for ($time = $starttime; (Get-Date ([timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($time))) -uformat "%m") -eq $mm; $time = $time + 3*86400)
		{
			Get-Date ([timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($time))) -uformat "%m-%d"
		}
		#update endtime
		$endtime = $time - 3*86400
		# variable filename
		$variable_file_path_ssh =  "\ssh\$year\OFES_01deg_ssh_$region_$year$mm.nc"
		$variable_file_path_s    =  "\s\$year\OFES_01deg_s_$region_$year$mm.nc"
		$variable_file_path_t    =  "\t\$year\OFES_01deg_t_$region_$year$mm.nc"
		$variable_file_path_u    =  "\u\$year\OFES_01deg_u_$region_$year$mm.nc"
		$variable_file_path_v   =  "\v\$year\OFES_01deg_v_$region_$year$mm.nc"		
		$variable_file_path_w   =  "\w\$year\OFES_01deg_w_$region_$year$mm.nc"
	
		# variables keys(these keys have been update in 2025/05/22)
		#$s_key = "face_930e_5a79.nc?salinity"
		#$t_key = "1b16_9fed_896e.nc?temp"
		#$ssh_key = "73d3_b3d4_4e8e.nc?eta"
		#$u_key = "b0d2_0156_7195.nc?uvel"
		#$v_key = "554e_33e2_83ca.nc?vvel"
		#$w_key = "9b74_dfe4_ce4e.nc?wvel"

		# variables keys
		$s_key = "97c6_096d_d307.nc?salinity"
		$t_key = "6aee_06a1_f39c.nc?temp"
		$ssh_key = "c188_03f3_eec6.nc?eta"
		$u_key = "89b5_b342_f7ca.nc?uvel"
		$v_key = "472f_7f47_36de.nc?vvel"
		$w_key = "c210_a645_0c97.nc?wvel"
		
		# download sea surface height
        		$filename=$filepath+$variable_file_path_ssh
		$url="http://apdrc.soest.hawaii.edu/erddap/griddap/hawaii_soest_"+$ssh_key+"[($starttime):1:($endtime)][(0.0):1:(0.0)][($minlat):1:($maxlat)][($minlon):1:($maxlon)]"
        		echo $url
        		echo $filename" is downloading"

		# use these method while having internet connect problem
		for ($downloadFlag = 0; $downloadFlag -eq 0; echo $downloadFlag)
		{
			try
			{
				$client.DownloadFile($url,$filename) 
				$downloadFlag = 1
			}
			catch
			{
				echo "download failed! redownloading..."
				$downloadFlag = 0
			}
		}

		# download salinity
        		$filename=$filepath+$variable_file_path_s
		$url="http://apdrc.soest.hawaii.edu/erddap/griddap/hawaii_soest_"+$s_key+"[($starttime):1:($endtime)][($mindep):1:($maxdep)][($minlat):1:($maxlat)][($minlon):1:($maxlon)]"
        		echo $url
        		echo $filename" is downloading"

		# use these method while having internet connect problem
		for ($downloadFlag = 0; $downloadFlag -eq 0; echo $downloadFlag)
		{
			try
			{
				$client.DownloadFile($url,$filename) 
				$downloadFlag = 1
			}
			catch
			{
				echo "download failed! redownloading..."
				$downloadFlag = 0
			}
		}

		# download tempature
        		$filename=$filepath+$variable_file_path_t
		$url="http://apdrc.soest.hawaii.edu/erddap/griddap/hawaii_soest_"+$t_key+"[($starttime):1:($endtime)][($mindep):1:($maxdep)][($minlat):1:($maxlat)][($minlon):1:($maxlon)]"
        		echo $url
        		echo $filename" is downloading"

		# use these method while having internet connect problem
		for ($downloadFlag = 0; $downloadFlag -eq 0; echo $downloadFlag)
		{
			try
			{
				$client.DownloadFile($url,$filename) 
				$downloadFlag = 1
			}
			catch
			{
				echo "download failed! redownloading..."
				$downloadFlag = 0
			}
		}

		# download zonal velocity
        		$filename=$filepath+$variable_file_path_u
		$url="http://apdrc.soest.hawaii.edu/erddap/griddap/hawaii_soest_"+$u_key+"[($starttime):1:($endtime)][($mindep):1:($maxdep)][($minlat):1:($maxlat)][($minlon):1:($maxlon)]"
        		echo $url
        		echo $filename" is downloading"

		# use these method while having internet connect problem
		for ($downloadFlag = 0; $downloadFlag -eq 0; echo $downloadFlag)
		{
			try
			{
				$client.DownloadFile($url,$filename) 
				$downloadFlag = 1
			}
			catch
			{
				echo "download failed! redownloading..."
				$downloadFlag = 0
			}
		}

		# download meridional velocity
        		$filename=$filepath+$variable_file_path_v
		$url="http://apdrc.soest.hawaii.edu/erddap/griddap/hawaii_soest_"+$v_key+"[($starttime):1:($endtime)][($mindep):1:($maxdep)][($minlat):1:($maxlat)][($minlon):1:($maxlon)]"
        		echo $url
        		echo $filename" is downloading"

		# use these method while having internet connect problem
		for ($downloadFlag = 0; $downloadFlag -eq 0; echo $downloadFlag)
		{
			try
			{
				$client.DownloadFile($url,$filename) 
				$downloadFlag = 1
			}
			catch
			{
				echo "download failed! redownloading..."
				$downloadFlag = 0
			}
		}

		# download vertical velocity
        		$filename=$filepath+$variable_file_path_w
		$url="http://apdrc.soest.hawaii.edu/erddap/griddap/hawaii_soest_"+$w_key+"[($starttime):1:($endtime)][($mindep):1:($maxdep)][($minlat):1:($maxlat)][($minlon):1:($maxlon)]"
        		echo $url
        		echo $filename" is downloading"
		
		#$client.DownloadFile($url,$filename)

		# use these method while having internet connect problem
		for ($downloadFlag = 0; $downloadFlag -eq 0; echo $downloadFlag)
		{
			try
			{
				$client.DownloadFile($url,$filename) 
				$downloadFlag = 1
			}
			catch
			{
				echo "download failed! redownloading..."
				$downloadFlag = 0
			}
		}
		
		#update starttime
		$starttime = $time
        		echo "ok"
	}
	$starttime = $starttime + 3*86400
}