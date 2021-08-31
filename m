Content-Type: multipart/mixed; boundary="===============4859874644742440382=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] test-runner: Fix verbose check for processes in namespaces
Date: Tue, 31 Aug 2021 10:11:18 -0500
Message-ID: <69f15b24-9e28-5a9c-21ca-b4c1673e0c06@gmail.com>
In-Reply-To: <20210828031054.28451-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4859874644742440382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/21 10:10 PM, Andrew Zaborowski wrote:
> Check whether verbose output is enabled for process name arg[0] before
> prepending the "ip netns exec" part to arg since arg[0] is going to be
> "ip" after that.
> ---
>   tools/test-runner | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============4859874644742440382==--

