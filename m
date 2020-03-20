Content-Type: multipart/mixed; boundary="===============5566872803178146719=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] frame-xchg: Drop l_io read destroy handler
Date: Fri, 20 Mar 2020 10:48:11 -0500
Message-ID: <569f855a-a94d-dc22-e891-2b67361491d3@gmail.com>
In-Reply-To: <20200320162022.16761-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5566872803178146719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/20/20 11:20 AM, Andrew Zaborowski wrote:
> This function was intended to catch socket errors and destroy the group
> but it would leak the l_io object if that happened, and if called on
> ordinary shutdown it could cause a crash.  Since we're now assuming
> that the netlink socket operations never fail just remove it.
> ---
>   src/frame-xchg.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5566872803178146719==--

