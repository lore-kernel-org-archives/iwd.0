Content-Type: multipart/mixed; boundary="===============1214180427653886797=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] auto-t: throw exception if hostapd can't send BSS
 transition req
Date: Thu, 28 Jan 2021 13:31:29 -0600
Message-ID: <da42b97f-e76c-a0e1-7142-583d7c46c4ae@gmail.com>
In-Reply-To: <20210128092601.1257918-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1214180427653886797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 1/28/21 3:26 AM, Alvin =C5=A0ipraga wrote:
> The testAPRoam autotest was silently failing on my machine until I
> realized that my distribution hostapd (Arch Linux) is not built with
> CONFIG_WNM_AP=3Dy. Indeed, it is also disabled by default in upstream
> hostapd. This resulted in the send_bss_transition() function of
> hostapd.py silently failing. With this change, throw an exception in
> case the BSS_TM_REQ command does not succeed to hopefully save others
> the time of debugging this problem.
> ---
>   autotests/util/hostapd.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1214180427653886797==--

