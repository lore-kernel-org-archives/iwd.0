Content-Type: multipart/mixed; boundary="===============6982535827500693761=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] client: apply format attribute to two functions
Date: Wed, 08 Apr 2020 14:37:04 +0000
Message-ID: <1d9fc8ec-d800-a135-083e-0a45c5029470@gmail.com>
In-Reply-To: <20200408033243.587218-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6982535827500693761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rosen,

On 4/7/20 10:32 PM, Rosen Penev wrote:
> Clang was able to find these extra ones.
> ---
>   client/agent.c   | 2 +-
>   client/display.h | 6 ++++--
>   2 files changed, 5 insertions(+), 3 deletions(-)

Looks fine to me, but gcc now complains:

   CC       client/display.o
client/display.c: In function =E2=80=98display_enable_cmd_prompt=E2=80=99:
client/display.c:537:10: error: zero-length gnu_printf format string =

[-Werror=3Dformat-zero-length]
   537 |  display("");
       |          ^~

Regards,
-Denis
--===============6982535827500693761==--

