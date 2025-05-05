Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FDD22330F
	for <iwd@lists.linux.dev>; Mon,  5 May 2025 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446721; cv=none; b=Ma5O8cFUdHB+eW6RO9z+ns363Z721OdQi/qlXGva+0oU4u+tCUDXpH/LcAwl/4EH5Z2tkui9dhAlVnIMENaNhOVch0xT0RFGb+8W6R5fh2v/fag6oM3hJiH2uJqybcDEwu9MMd6I9cEm3X9j6BkuCA26HolcYOatQHOXG0aUTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446721; c=relaxed/simple;
	bh=HH8trfS2HMpJkqxrFPpMQXM5YzwqPbhC3HrEFdpB3eY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qVTwmw6oIeIGhSkUNJhd0cmzEgUMkjsIGzOsbeEoRuLVoX3ffFWqrmmdpOVKXvPq8nAKT7otUAk3pQEZenVkVLjSUtDjPa485WdKOkIIAqgvePGXWnoyJycB6/081o5uH2xjw7HNgxsRERm/PH4gZb5sJ106grTnFztFViiuiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fee4.dip0.t-ipconnect.de [79.249.254.228])
	by mail.holtmann.org (Postfix) with ESMTPSA id D96B6CED0A;
	Mon,  5 May 2025 13:57:52 +0200 (CEST)
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
In-Reply-To: <D9NMMJZ63E59.YC0XX4QP9HYU@mailbox.org>
Date: Mon, 5 May 2025 13:57:42 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <5595AB40-CF63-4118-8DFA-3FFEAA091F5D@holtmann.org>
References: <D9NMMJZ63E59.YC0XX4QP9HYU@mailbox.org>
To: Andreas Radke <andreas.radke@mailbox.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

Hi Andreas,

> the new 3.7 release gives a test failure compiling for Arch Linux
> using gcc15:
>=20
> .. contents:: :depth: 2
>=20
> FAIL: unit/test-storage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> test-storage: unit/test-storage.c:41: test_short_encrypted_bytes: =
Assertion
> `__storage_decrypt(settings, "mySSID", &changed) < 0' failed.
> TAP version 12
> 1..1
> not ok 1 - /storage/profile encryption
> FAIL: unit/test-storage 1 - /storage/profile encryption

it works for me. I checked on Debian and Fedora on x86_64, ppc32 and =
aarch64. What architecture is this?

Can you check the return value of __storage_decrypt().

Regards

Marcel

