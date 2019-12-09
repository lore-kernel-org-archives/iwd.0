Content-Type: multipart/mixed; boundary="===============4726927026942514327=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] doc: Generalize wsc-api method descriptions
Date: Sun, 08 Dec 2019 23:10:11 -0600
Message-ID: <135f00ad-c7ca-c1f7-2335-064dce6762fe@gmail.com>
In-Reply-To: <20191205032244.5957-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4726927026942514327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/4/19 9:22 PM, Andrew Zaborowski wrote:
> ---
>   doc/wsc-api.txt | 42 +++++++++++++++++++++++++-----------------
>   1 file changed, 25 insertions(+), 17 deletions(-)
> =


<snip>

> @@ -35,10 +40,12 @@ Methods		void PushButton()
>   			digit suitable for use by most user interfaces.
>   =

>   		void StartPin(string pin)
> -			Start WSC in PIN mode.  If iwd's WSC configuration
> -			indicates that the device does not support a display,
> -			a static PIN from the main.conf configuration file is
> -			used.  Contents of pin are ignored in this case.
> +
> +			Start WSC or connect to a specific P2P peer in PIN
> +			mode.  If iwd's WSC configuration indicates that the
> +			device does not support a display, a static PIN from
> +			the main.conf configuration file is used.  Contents
> +			of pin are ignored in this case.

Reminds me that I don't think we implement this main.conf part.

>   =

>   			Otherwise, the pin provided will be utilized.  This
>   			can be an automatically generated PIN that contains a


Applied, thanks.

Regards,
-Denis
--===============4726927026942514327==--

