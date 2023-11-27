Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EDF18C2D
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id CF525CECC8;
	Mon, 27 Nov 2023 11:30:27 +0100 (CET)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] adhoc: Fix compilation on old systems
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231127032029.1316478-1-denkenz@gmail.com>
Date: Mon, 27 Nov 2023 11:30:17 +0100
Cc: Grant Erickson <gerickson@nuovations.com>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5A312BE-F67F-4C6A-AB00-96BC55053187@holtmann.org>
References: <20231127032029.1316478-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Denis,

>  CC       src/adhoc.o
> In file included from src/adhoc.c:28:0:
> /usr/include/linux/if.h:234:19: error: field =E2=80=98ifru_addr=E2=80=99=
 has incomplete type
>   struct sockaddr ifru_addr;
>                   ^
> /usr/include/linux/if.h:235:19: error: field =E2=80=98ifru_dstaddr=E2=80=
=99 has incomplete type
>   struct sockaddr ifru_dstaddr;
>                   ^
> /usr/include/linux/if.h:236:19: error: field =E2=80=98ifru_broadaddr=E2=80=
=99 has incomplete type
>   struct sockaddr ifru_broadaddr;
>                   ^
> /usr/include/linux/if.h:237:19: error: field =E2=80=98ifru_netmask=E2=80=
=99 has incomplete type
>   struct sockaddr ifru_netmask;
>                   ^
> /usr/include/linux/if.h:238:20: error: field =E2=80=98ifru_hwaddr=E2=80=99=
 has incomplete type
>   struct  sockaddr ifru_hwaddr;
>                    ^
> ---
> src/adhoc.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied.

Regards

Marcel

