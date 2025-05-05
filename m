Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F1199931
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460839; cv=none; b=kwp8PfWG8GbrtWHHj4ztrOsVlCuZB789st5hn9WGGX7CsqwYG2Q2cI4YrJaeWkJNM8uNf4HxhBfH6EY0RQR+vAOow9svz1K+5NNwUrE2sth6Ojm75M7x/tvDGBZjYz2VNMLgOCS7vCWSpq2kEHHCttVvbiqI7Ee0RjqmHg5iAOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460839; c=relaxed/simple;
	bh=RwRMTAXdWx3ofUy9zTqHA63Lr9hNhBg1OC1gnbLLqDU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lY/nM7KA3lsxM5/bEN+5fg7MHQhY7fANM3MPaGRvZ0AKFxy8aeZCSWTRi3x+WRrrw5KD5Ti1QPTSID2aMdRU5UzatE9s+tNwHDDwGjK4hl1oK5mthzhT+qwnUP2sMvNm0KST/7209B8qYIaIJuTKNUvVjqeCy3v+mzlNqZkZiP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fee4.dip0.t-ipconnect.de [79.249.254.228])
	by mail.holtmann.org (Postfix) with ESMTPSA id 91EF4CECE4;
	Mon,  5 May 2025 18:00:35 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: test failure in 3.7
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <D9OAJCNF22SX.1K21DR8JE54M7@archlinux.org>
Date: Mon, 5 May 2025 18:00:25 +0200
Cc: James Prestwood <prestwoj@gmail.com>,
 Andreas Radke <andreas.radke@mailbox.org>,
 iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <85F1CEAD-0674-4BC3-BF90-BAE7018991F2@holtmann.org>
References: <D9NMMJZ63E59.YC0XX4QP9HYU@mailbox.org>
 <5595AB40-CF63-4118-8DFA-3FFEAA091F5D@holtmann.org>
 <4c9c290a-9c9c-4956-a5d1-b0eef0a7dcf2@gmail.com>
 <D9OAJCNF22SX.1K21DR8JE54M7@archlinux.org>
To: Andreas Radke <andyrtr@archlinux.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi Andreas,

> I can confirm that building inside the live x86_64 system actually =
passes the
> test and only the package build inside the chroot environment fails. =
For now=20
> I'm going to disable test-storage like we do with test-wsc for chroot
> builds.

hmmm. Why would it fail in a chroot. Can you get us the error code it =
returns so we can see where it fails.

Regards

Marcel

