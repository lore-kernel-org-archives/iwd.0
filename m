Content-Type: multipart/mixed; boundary="===============0140719497888302390=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: allow all unit tests to be run in VM
Date: Wed, 09 Oct 2019 14:33:38 -0500
Message-ID: <ebd101fc-fa02-101f-3bda-c73448e06421@gmail.com>
In-Reply-To: <20191009165700.12739-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0140719497888302390==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/9/19 11:57 AM, James Prestwood wrote:
> The -U parameter only allowed for a list of unit tests to be run.
> Most of the time for sanity checking you want to run all the unit
> tests so this has been changed to take an optional argument.
> =

> Now, the -U flag (by itself) will run all unit tests. Running a
> single or list of unit tests can still be achieved by:
> =

> --unit-tests=3Dtest-eapol,test-crypto
> ---
>   tools/test-runner.c | 48 ++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 37 insertions(+), 11 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0140719497888302390==--

