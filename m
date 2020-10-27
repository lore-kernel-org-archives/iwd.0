Content-Type: multipart/mixed; boundary="===============0380908861191047719=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] monitor: print survey info results
Date: Tue, 27 Oct 2020 09:54:12 -0500
Message-ID: <3800c235-a236-7af2-d405-ef32323465c0@gmail.com>
In-Reply-To: <20201027122912.345502-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0380908861191047719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 10/27/20 7:31 AM, Alvin Sipraga wrote:
> Example output:
> =

>    > Result: New Survey Results (0x33) len 76 [multi]         14.062327
>      Interface Index: 6 (0x00000006)
>      Survey Info: len 64
>          Frequency: 2472 (0x000009a8)
>          Noise dBm: -89
>          Survey Time: 100 (0x0000000000000064)
>          Busy Time: 4 (0x0000000000000004)
>          RX Time: 3 (0x0000000000000003)
>          TX Time: 0 (0x0000000000000000)
> ---
>   monitor/nlmon.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)

Applied, thanks!

Regards,
-Denis

--===============0380908861191047719==--

