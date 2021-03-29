Content-Type: multipart/mixed; boundary="===============0238054939026567724=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/3] netdev: better handle associate timeouts with
 auth_protos
Date: Mon, 29 Mar 2021 15:50:04 -0500
Message-ID: <e6e82c44-d424-fc4a-c13f-9b047f3bfe5e@gmail.com>
In-Reply-To: <20210329204351.718429-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0238054939026567724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/29/21 3:43 PM, James Prestwood wrote:
> Any auth proto which did not implement the assoc_timeout handler
> could end up getting 'stuck' forever if there was an associate
> timeout. This is because in the event of an associate timeout IWD
> only sets a few flags and relies on the connect event to actually
> handle the failure. The problem is a connect event never comes
> if the failure was a timeout.
> =

> To fix this we can explicitly fail the connection if the auth
> proto has not implemented assoc_timeout or if it returns false.
> ---
>   src/netdev.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> =

> v2:
>   * Moved the failure into the actual timeout case as the
>     connect event *does* come unless there was a timeout
> =


Applied, thanks.

Regards,
-Denis

--===============0238054939026567724==--

