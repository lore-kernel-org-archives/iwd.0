Content-Type: multipart/mixed; boundary="===============0324713519384047706=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/8] ft: separate ft_sm from ft_process_ies
Date: Fri, 16 Apr 2021 11:31:26 -0500
Message-ID: <fb37213f-9eb9-370c-1ffd-9b6cc623885e@gmail.com>
In-Reply-To: <20210415224508.1823614-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0324713519384047706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/15/21 5:45 PM, James Prestwood wrote:
> To prepare for some refactoring remove the ft_sm dependency
> from ft_process_ies and instead only make it depend on the
> handshake_state object.
> ---
>   src/ft.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0324713519384047706==--

