Content-Type: multipart/mixed; boundary="===============2036064320851871928=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] auto-t: fix testP2P
Date: Tue, 09 Nov 2021 13:10:24 -0600
Message-ID: <b9aee7ea-3064-07da-b637-bcec0e198cdd@gmail.com>
In-Reply-To: CANvyuLWd7rvP8LvxCYza5kZZpffeze6Fa-nBUUmb7gT7fAqUEQ@mail.gmail.com

--===============2036064320851871928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On 11/9/21 12:58 PM, Torsten Schmitz wrote:
> testP2P was failing with
> FileNotFoundError: [Errno 2] No such file or directory:
> '/tmp/wpa_supplicant.conf'
> ---
>   tools/test-runner | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


This fails to apply:

denkenz(a)localhost ~/iwd-master $ git am ~/merge/\[PATCH\]\ auto-t\:\ fix\ =

testP2P.eml
Applying: auto-t: fix testP2P
error: corrupt patch at line 13
Patch failed at 0001 auto-t: fix testP2P

Regards,
-Denis
--===============2036064320851871928==--

