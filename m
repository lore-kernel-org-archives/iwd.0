Content-Type: multipart/mixed; boundary="===============3664835549443056974=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] eapol: do not parse RSN for WPA1 in 1 of 4
Date: Thu, 17 Oct 2019 18:48:51 -0500
Message-ID: <53ce7dee-5075-02b3-61e4-e5d472e17767@gmail.com>
In-Reply-To: <20191017234316.4271-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3664835549443056974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/17/19 6:43 PM, James Prestwood wrote:
> A recent change checked the return value of ie_parse_rsne_from_data
> inside the ptk 1/4 handler. This seemed safe, but actually caused
> the eapol unit test to fail.
> =

> The reason was because eapol was parsing the IEs assuming they were
> an RSN, when they could be a WPA IE (WPA1 not WPA2). The WPA case
> does not end up using the rsn_info at all, so having rsn_info
> uninitialized did not pose a problem. After adding the return value
> check it was found this fails every time for WPA1.
> =

> Since the rsn_info is not needed for WPA1 we can only do the RSN
> parse for WPA2 and leave rsn_info uninitialized.
> ---
>   src/eapol.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =


applied, thanks.

Regards,
-Denis

--===============3664835549443056974==--

