Content-Type: multipart/mixed; boundary="===============7664327600244062451=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: move ofono/phonesim logs into test dir
Date: Thu, 14 Nov 2019 15:23:25 -0600
Message-ID: <bb67a231-ef1e-90a9-7ec8-7e251769a8d1@gmail.com>
In-Reply-To: <20191114195751.27895-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7664327600244062451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/14/19 1:57 PM, James Prestwood wrote:
> These two processes are executed per-test so they can be passed the
> test name and have the logs stored only in tests that actually need
> them rather than at the top level.
> ---
>   tools/test-runner.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7664327600244062451==--

