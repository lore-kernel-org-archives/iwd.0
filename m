Content-Type: multipart/mixed; boundary="===============7265639929287775352=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/6] ie: add info struct for OWE transition
Date: Wed, 22 Sep 2021 13:58:38 -0500
Message-ID: <b82b26f5-822d-01b0-32be-e4a102cf1c3f@gmail.com>
In-Reply-To: 20210922182655.46220-1-prestwoj@gmail.com

--===============7265639929287775352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/22/21 1:26 PM, James Prestwood wrote:
> These members are currently stored in scan_bss but with the
> addition of operating class/band info this will become 5
> separate members. This is a bit excessive to store in scan_bss
> separately so instead this structure can hold everything related
> to the OWE transition IE.
> ---
>   src/ie.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> =


Patches 1-3 applied, thanks.

Regards,
-Denis
--===============7265639929287775352==--

