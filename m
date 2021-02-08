Content-Type: multipart/mixed; boundary="===============6962187060812110755=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: clean up dbus path file properly
Date: Mon, 08 Feb 2021 11:57:05 -0600
Message-ID: <2e5c9add-70ce-8c04-bc54-3696ac705e0d@gmail.com>
In-Reply-To: <20210208175359.573258-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6962187060812110755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/8/21 11:53 AM, James Prestwood wrote:
> Dbus should be started as a multi-test process from the
> TestContext, which leaves the dbus address file around for
> the full test run. For Namespaces dbus-daemon should be
> closed when the Namespace closes.
> ---
>   tools/test-runner | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6962187060812110755==--

