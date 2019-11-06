Content-Type: multipart/mixed; boundary="===============8823089642052106008=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: special case python3 verbose option
Date: Wed, 06 Nov 2019 15:16:58 -0600
Message-ID: <fadfddd7-5ead-835e-e390-f8591ad1421a@gmail.com>
In-Reply-To: <20191105233604.12933-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8823089642052106008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/5/19 5:36 PM, James Prestwood wrote:
> Historically if you wanted to see output from a python test you needed
> to specify -v pytests. This was also the case if IWD was started from
> python.
> =

> Nearly every time I run test-runner I would specify "-v iwd,pytests"
> only to get the IWD output on these specific tests.
> =

> Instead we can special case 'python3' (previously 'pytests') inside
> execute_program so that turning on verbosity for 'iwd' also turns it
> on for the python tests.
> ---
>   tools/test-runner.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8823089642052106008==--

