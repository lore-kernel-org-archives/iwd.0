Content-Type: multipart/mixed; boundary="===============2187728083669821392=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] monitor: Print WFD IE contents
Date: Fri, 20 Mar 2020 10:47:43 -0500
Message-ID: <7d171296-84cb-c48b-cfa2-def4f92a9291@gmail.com>
In-Reply-To: <20200320160905.12675-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2187728083669821392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/20/20 11:09 AM, Andrew Zaborowski wrote:
> Only print the WFD version 2.1.0 spec subelements which removed all the
> low level video format details from the IEs so this code is much
> shorter.
> ---
>   monitor/nlmon.c | 317 +++++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 303 insertions(+), 14 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2187728083669821392==--

