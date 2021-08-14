Content-Type: multipart/mixed; boundary="===============6605181002048472915=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] auto-t: return existing instance from HostapdCLI
Date: Fri, 13 Aug 2021 20:39:33 -0500
Message-ID: <d9d0c4f2-670a-2d77-97ce-d682a48048a3@gmail.com>
In-Reply-To: <20210813224554.816379-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6605181002048472915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/13/21 5:45 PM, James Prestwood wrote:
> This addresses the TODO where HostapdCLI was creating separate
> objects each time HostapdCLI was called. This was worked around
> by manually setting the important members but instead the class
> can be re-worked to act as somewhat of a singleton, per-config
> at least.
> =

> If there is no HostapdCLI instance for a given config one is
> created and initialized. Subsequent HostapdCLI calls (for the
> same config) will be returned the same object rather than a
> new one.
> ---
>   autotests/util/hostapd.py | 48 +++++++++++++++++++++++----------------
>   tools/test-runner         |  4 ++++
>   2 files changed, 33 insertions(+), 19 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============6605181002048472915==--

