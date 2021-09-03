Content-Type: multipart/mixed; boundary="===============5186697580784848626=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] test-runner: fix --monitor option
Date: Fri, 03 Sep 2021 13:20:26 -0500
Message-ID: <317cc868-0f75-8527-2034-06be773b8003@gmail.com>
In-Reply-To: <20210901233852.2796740-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5186697580784848626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/1/21 6:38 PM, James Prestwood wrote:
> Two issues:
>   - log-gid/uid was not being set
>   - the log file was being appended if it already existed
> ---
>   tools/test-runner | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============5186697580784848626==--

