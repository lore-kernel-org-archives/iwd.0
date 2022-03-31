Content-Type: multipart/mixed; boundary="===============5066384320718320112=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 01/14] test-runner: Move environment setup into own
 module
Date: Thu, 31 Mar 2022 18:13:39 -0500
Message-ID: <b2218ddd-f312-73bc-6c16-a5e55ff1bb55@gmail.com>
In-Reply-To: 20220331231641.484200-1-prestwoj@gmail.com

--===============5066384320718320112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/31/22 18:16, James Prestwood wrote:
> This (as well as subsequent commits) will separate test-runner into two
> parts:
> =

> 1. Environment setup
> 2. Running tests
> =

> Spurred by interest in adding UML/host support, test-runner was in need
> of a refactor to separate out the environment setup and actually running
> the tests.
> =

> The environment (currently only Qemu) requires quite a bit of special
> handling (ctypes mounting/reboot, 9p mounts, tons of kernel options etc)
> which nobody writing tests should need to see or care about. This has all
> been moved into 'runner.py'.
> =

> Running the tests (inside test-runner) won't change much.
> =

> The new 'runner.py' module adds an abstraction class which allows differe=
nt
> Runner's to be implemented, and setup their own environment as they see
> fit. This is in preparation for UML and Host runners.
> ---
>   tools/runner.py | 485 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 485 insertions(+)
>   create mode 100644 tools/runner.py
> =


All applied, thanks.

Regards,
-Denis

--===============5066384320718320112==--

