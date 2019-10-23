Content-Type: multipart/mixed; boundary="===============2827778606583843675=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/7] t-runner: Fix mem leak with sim keys
Date: Tue, 22 Oct 2019 21:57:59 -0500
Message-ID: <bc4cabf7-9e18-b7a0-2c58-ecfdcc922338@gmail.com>
In-Reply-To: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2827778606583843675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/22/19 6:13 PM, Tim Kourt wrote:
> Use l_settings_get_value instead of l_settings_get_string to
> prevent unnecessary memory duplication.
> ---
>   tools/test-runner.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============2827778606583843675==--

