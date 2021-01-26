Content-Type: multipart/mixed; boundary="===============4177814377251404686=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] test-runner: fix verbose arguments as single string
Date: Tue, 26 Jan 2021 13:42:05 -0600
Message-ID: <1b433402-ea8c-806b-96e1-3f6afe6abbe7@gmail.com>
In-Reply-To: <20210126174657.867692-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4177814377251404686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/26/21 11:46 AM, James Prestwood wrote:
> The verbose arguments come in from the QEMU command line as a
> single string. This should have been split into an array immediately
> but was not. This led to issues like hostapd debug being enabled
> when "-v hostapd_cli" was passed in.
> ---
>   tools/test-runner | 3 +++
>   1 file changed, 3 insertions(+)
> =


Patches 1-3 applied, thanks.

Regards,
-Denis
--===============4177814377251404686==--

