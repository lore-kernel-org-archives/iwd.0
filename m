Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9964A18C2F
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtpclient.apple (p4fefc822.dip0.t-ipconnect.de [79.239.200.34])
	by mail.holtmann.org (Postfix) with ESMTPSA id 3AC6ACECC8;
	Mon, 27 Nov 2023 11:31:01 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2 1/6] ie: Move AKM suite converter from netdev
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20231127043924.1328538-1-denkenz@gmail.com>
Date: Mon, 27 Nov 2023 11:30:51 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <4B948512-EA98-4733-9ACD-88F163F6CDB4@holtmann.org>
References: <20231127043924.1328538-1-denkenz@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Denis,

> It is more logical to host this function inside ie.c than netdev.c.
> Particularly since ie_rsn_cipher_suite_to_cipher is already present in
> ie.c.
> ---
> src/ie.c     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> src/ie.h     |  2 ++
> src/netdev.c | 47 +----------------------------------------------
> 3 files changed, 49 insertions(+), 46 deletions(-)

all 6 patches haven been applied.

Regards

Marcel

