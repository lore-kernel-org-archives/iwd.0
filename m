Content-Type: multipart/mixed; boundary="===============1193425709020202705=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] doc: document SSID property on AP interface
Date: Mon, 01 Feb 2021 16:21:26 -0600
Message-ID: <f8c486a7-ef55-4360-6e57-10471ba975fc@gmail.com>
In-Reply-To: <20210201220518.36975-4-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1193425709020202705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/1/21 4:05 PM, James Prestwood wrote:
> ---
>   doc/access-point-api.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> =

> diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
> index 9682b3c7..27f4e244 100644
> --- a/doc/access-point-api.txt
> +++ b/doc/access-point-api.txt
> @@ -40,3 +40,8 @@ Methods		void Start(string ssid, string psk)
>   Properties	boolean Started [readonly]
>   =

>   			Reflects whether an access point has been started.
> +
> +		string SSID [readonly]

Do we want to call it 'Name' to be symmetrical with Network?
also, [readonly, optional]

> +
> +			The SSID being broadcast for a started AP. This will be
> +			an empty string prior to the AP being started.

Ah I think we should rather omit it if the AP isn't started
> =


Regards,
-Denis
--===============1193425709020202705==--

