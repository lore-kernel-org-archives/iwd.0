Content-Type: multipart/mixed; boundary="===============7539075184871394386=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] test-runner: add option to specify subtests to run
Date: Mon, 16 Nov 2020 17:06:05 -0600
Message-ID: <4af5d55c-dd2b-596d-061f-41bd816cf516@gmail.com>
In-Reply-To: <20201116222514.3486808-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7539075184871394386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/16/20 4:25 PM, James Prestwood wrote:
> You can now specify a limited list of subtests to run out of a
> full auto-test using --sub-tests,-S. This option is limited in
> that it is only meant to be used with a single autotest (since
> it doesn't make much sense otherwise).
> =

> The subtest can be specified both with or without the file
> extension.
> =

> Example usage:
> =

> ./test-runner -A testAP -S failure_test,dhcp_test.py
> =

> This will only run the two subtests and exclude any other *.py
> tests present in the test directory.
> ---
>   tools/test-runner | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> =


All applied, thanks.

Regards,
-Denis

--===============7539075184871394386==--

