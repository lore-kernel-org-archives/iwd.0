Content-Type: multipart/mixed; boundary="===============7877002666619377828=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/4] doc: document AKMSuite diagnostic value
Date: Thu, 25 Mar 2021 10:45:47 -0500
Message-ID: <8e331aff-72fc-bf9b-b4b9-4a8eb8ab2323@gmail.com>
In-Reply-To: <20210324230538.583325-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7877002666619377828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/24/21 6:05 PM, James Prestwood wrote:
> ---
>   doc/station-diagnostic-api.txt | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/doc/station-diagnostic-api.txt b/doc/station-diagnostic-api.=
txt
> index b5a73b5d..6470fa56 100644
> --- a/doc/station-diagnostic-api.txt
> +++ b/doc/station-diagnostic-api.txt
> @@ -23,6 +23,8 @@ Methods		dict GetDiagnostics()
>   =

>   			Frequency - Frequency of currently connected BSS.
>   =

> +			AKMSuite - The chosen AKM for the current connection.
> +

This doesn't feel right somehow.  I would expect AKMSuite to be something l=
ike: =

'00-0F0AC:9 FT over SAE' or something to that effect.  Similar to how iwmon=
 does it.

Since we're going for something more human-palatable, how about just naming=
 this =

'Security' instead.  With possible values being:

WPA-Personal, WPA2-Personal, WPA3-Personal, WPA2-Enterprise, OWE.  With may=
be '+ =

FT', '+ FILS' or 'FT/FILS' suffixes and whatever others we feel are importa=
nt.

>   			RSSI [optional] - The RSSI of the currently connected BSS.
>   =

>   			AverageRSSI [optional] - Average RSSI of currently connected BSS.
> =


Regards,
-Denis
--===============7877002666619377828==--

