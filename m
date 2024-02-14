Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894D22071
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928771; cv=none; b=bVLv3HGyzWso5wcMkdUsPLFK9Jixa7T2HRx07TnfeiFgzipdafbLQIuPMkxtS3Hkl6XZdSp8Ver1ogdzW1powMAFA/LN0SQE2A6M8MLemTEEOVLVJA2Ezshjm6QAeYfyFRLG8KxgOjNbC0EIeZ9GY9mpEQ8Z3VDwNi/acj4uIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928771; c=relaxed/simple;
	bh=zR4wuVIwzG4WCNvLfJ4Drb9Dn5utBmWwfmYYPILYWAY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H3O6cIP+pOn/OlOXGr3WjqJ1fFwlimixne6ZCzVP5aCNf0lVQwbbW2H1E5SiiogMzKq/3xGmUGEPJFUHhW2l3em3EYtoFb8ODaDT3kqNDGCyMLYtYoyrtJwf/DpUuJQ5yzYXALC0BJtfEnVctJ+savMnY9T69Hd/dIKzA95OY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa23.dip0.t-ipconnect.de [79.249.250.35])
	by mail.holtmann.org (Postfix) with ESMTPSA id 1E323CECBE;
	Wed, 14 Feb 2024 17:39:28 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] wiphy: include libgen.h to fix implicit def. with musl
 libc
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
Date: Wed, 14 Feb 2024 17:39:17 +0100
Cc: Clayton Craft <clayton@craftyguy.net>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC62FEA8-DA18-4084-A5B6-A96C82AE799B@holtmann.org>
References: <20240212184747.30422-1-clayton@craftyguy.net>
 <8b02ff06-9c2b-4503-8fb8-9784c2628394@gmail.com>
 <152B8E7F-C6D0-4827-AC38-25454FD6BAF7@holtmann.org>
 <f9970105-c1c7-484b-8e13-5ca5f5bae901@gmail.com>
 <34797D3A-D630-4D71-B4E8-BD29E9BB759C@holtmann.org>
 <b1b66222-6594-4775-94ed-2f17810029b1@gmail.com>
To: Denis Kenzior <denkenz@gmail.com>
X-Mailer: Apple Mail (2.3774.400.31)

Hi Denis,

>> Add a _get_driver is a good idea as well, but what is the reason for =
l_sysctl since sysctl is some specific system call.
>=20
> l_sysctl is used to write stuff into procfs or sysfs.  Naming comes =
from the sysctl(8) utility.

actually no. sysctl just handles /proc/sys/. It has nothing to do with =
sysfs.

Regards

Marcel

