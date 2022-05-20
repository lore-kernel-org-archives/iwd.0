Content-Type: multipart/mixed; boundary="===============1639742561853810104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/2] Document initial signal level notification
Date: Fri, 20 May 2022 15:13:06 -0500
Message-ID: <b59a8875-ec79-e863-3369-9f0fbcf21621@gmail.com>
In-Reply-To: 20220520185948.9533-2-jesse@twosheds.org

--===============1639742561853810104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesse,

On 5/20/22 13:59, Jesse Lentz wrote:
> Document the initial "Changed" method call following SignalLevelAgent
> registration.
> ---
>   doc/station-api.txt | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> =

> diff --git a/doc/station-api.txt b/doc/station-api.txt
> index 0bb372ab..05dd137e 100644
> --- a/doc/station-api.txt
> +++ b/doc/station-api.txt
> @@ -182,16 +182,17 @@ Methods		void Release(object device) [noreply]
>   		void Changed(object device, uint8 level) [noreply]
>   =

>   			This method gets called when the signal strength
> -			measurement for the device's connected network
> -			changes enough to go from one level to another out
> -			of the N ranges defined by the array of (N-1)
> -			threshold values passed to RegisterSignalLevelAgent().
> -			The level parameter is in the range from 0 to N,
> -			0 being the strongest signal or above the first
> -			threshold value in the array, and N being the
> -			weakest and below the last threshold value.  For
> -			example if RegisterSignalLevelAgent was called with
> -			the array [-40, -50, -60], the 'level' parameter of
> -			0 would mean signal is received at -40 or more dBm
> -			and 3 would mean below -60 dBm and might correspond
> -			to 1 out of 4 bars on a UI signal meter.
> +			measurement for the device's connected network changes
> +			enough to go from one level to another out of the N
> +			ranges defined by the array of (N-1) threshold values
> +			passed to RegisterSignalLevelAgent().  It also gets
> +			called immediately after the signal level agent is
> +			registered.  The level parameter is in the range from 0
> +			to N, 0 being the strongest signal or above the first
> +			threshold value in the array, and N being the weakest
> +			and below the last threshold value.  For example if
> +			RegisterSignalLevelAgent was called with the array [-40,

I think this line might be over 80 chars.

> +			-50, -60], the 'level' parameter of 0 would mean signal
> +			is received at -40 or more dBm and 3 would mean below
> +			-60 dBm and might correspond to 1 out of 4 bars on a UI
> +			signal meter.
> =


Otherwise looks good!

Regards,
-Denis
--===============1639742561853810104==--

