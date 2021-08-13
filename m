Content-Type: multipart/mixed; boundary="===============8008506363124564543=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] auto-t: fix testAgent use of Process
Date: Fri, 13 Aug 2021 15:19:02 -0500
Message-ID: <ae90c7a4-3b49-2db9-e7e7-111c0534a592@gmail.com>
In-Reply-To: <20210813202612.809470-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8008506363124564543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/13/21 3:26 PM, James Prestwood wrote:
> This test was accessing the subprocess object and calling terminate
> which ends up causing issues with test-runners own process cleanup.
> Instead kill() should be used.
> ---
>   autotests/testAgent/agent_test.py | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============8008506363124564543==--

