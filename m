Content-Type: multipart/mixed; boundary="===============3239183967688299007=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] adhoc: start both eapol SM's
Date: Mon, 14 Sep 2020 16:27:21 -0500
Message-ID: <76e8fadb-ce21-4c7d-9d41-598e24bb335d@gmail.com>
In-Reply-To: <20200914210407.428918-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3239183967688299007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/14/20 4:04 PM, James Prestwood wrote:
> At some point in the past starting only one SM worked. But now it does
> not. Both SM's need to be started for EAPoL to work properly and kick
> off both sets of handshakes.
> ---
>   src/adhoc.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied with a slight commit description change to mention the offending co=
mmit.

Regards,
-Denis

--===============3239183967688299007==--

