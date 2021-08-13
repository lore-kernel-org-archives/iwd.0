Content-Type: multipart/mixed; boundary="===============2079933272343107947=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] test-runner: implement non_block_wait
Date: Fri, 13 Aug 2021 11:16:39 -0500
Message-ID: <cb3561f3-cd13-8791-3157-08e97ff8fc07@gmail.com>
In-Reply-To: <20210813162440.793847-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2079933272343107947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/13/21 11:24 AM, James Prestwood wrote:
> There was a common bit of code all over test-runner and utilities
> which would wait for 'something' in a loop. At best these loops
> would do the right thing and use the GLib.iteration call as to not
> block the main loop, and at worst would not use it and just busy
> wait.
> =

> Namespace.non_block_wait unifies all these into a single API to
> a) do the wait correctly and b) prevent duplicate code.
> ---
>   tools/test-runner | 80 ++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 65 insertions(+), 15 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2079933272343107947==--

