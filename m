Content-Type: multipart/mixed; boundary="===============6327978796880168369=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: remove requirement for /var/lib/{ead,iwd}
Date: Wed, 14 Oct 2020 13:03:35 -0500
Message-ID: <b5677cf1-e417-a70f-9e3b-57a45265fd9c@gmail.com>
In-Reply-To: <20201014165557.199884-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6327978796880168369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/14/20 11:55 AM, James Prestwood wrote:
> The host systems configuration directories for IWD/EAD were
> being mounted in the virtual machine. This required that the
> host create these directories before hand. Instead we can
> just set up the system and IWD/EAD to use directories in /tmp
> that we create when we start the VM. This avoids the need for
> any host configuration.
> ---
>   autotests/testEAD/connection_test.py | 11 ++++++++---
>   autotests/util/iwd.py                | 10 +++++-----
>   tools/test-runner                    |  6 +++---
>   3 files changed, 16 insertions(+), 11 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============6327978796880168369==--

