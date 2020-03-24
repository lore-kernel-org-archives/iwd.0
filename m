Content-Type: multipart/mixed; boundary="===============7473070462133012719=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] test-runner: make default iwd_config_dir=/tmp
Date: Tue, 24 Mar 2020 16:32:31 -0500
Message-ID: <d9ccbfeb-1c43-2a36-91b6-2055f9754e67@gmail.com>
In-Reply-To: <20200324202403.26860-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7473070462133012719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/24/20 3:24 PM, James Prestwood wrote:
> The configuration value of iwd_config_dir was defaulting to /etc/iwd
> which, in the context of test-runner, is probably not the best idea.
> The system may have a main.conf file in /etc/iwd which could cause
> tests to fail or behave unexpectedly.
> =

> In addition all tests which use iwd_config_dir set it to /tmp anyways.
> Because of this, the new default value will be /tmp and no tests will
> even need to bother setting this.
> =

> The configuration value itself is not being removed because it may be
> useful to set arbitrary paths (e.g. /etc/iwd) for example when using
> the shell functionality.
> ---
>   tools/test-runner.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

all applied, thanks.

Regards,
-Denis

--===============7473070462133012719==--

