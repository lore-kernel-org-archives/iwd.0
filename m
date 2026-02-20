Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1E4D8CE
	for <iwd@lists.linux.dev>; Fri, 20 Feb 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581101; cv=none; b=cTh8pk91Q8Zaotb1Kr/GL23XAwp+2eNJwMnR2DtrP9dSVwVRUk9638OO0FW+XOqYaNuAwWcmgKj2jITfB/Z8BY3nqi2YKOkEql3grIDWk9Q+7P1ykg/xHW/kYa3XMGdVgiSt0o+rezzI0+FlVhuk0DSjMJNoK4dyf0wblH5KXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581101; c=relaxed/simple;
	bh=KjjgZF5AXpS6GYtKzIJEj53YlBwZL2t1x8yGpFx/TeI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LymVbCKwZWUTIayzw6JyKn0kEs47laURecCITgKAUuzgJaPOtaBLfUF/n9l4kq1zOjf4dqE+XXTChqWPEcj18m0fUs6ZE13Wt1rYpphbx52RkMX1mrLCHEymQTzaxwaYpWTu+j1BccmRlAbJwINrare1/HlTr0ysMZgZR9GOdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9fa4c.dip0.t-ipconnect.de [79.249.250.76])
	by mail.holtmann.org (Postfix) with ESMTPSA id EF844CECBE;
	Fri, 20 Feb 2026 10:51:38 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3] unit: Add better check for pkcs8_key_parser
 availability
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20260219122853.2234017-1-hadess@hadess.net>
Date: Fri, 20 Feb 2026 10:51:28 +0100
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <02B755BF-CFD7-4E70-A317-FE2B58828A96@holtmann.org>
References: <20260219122853.2234017-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
X-Mailer: Apple Mail (2.3864.400.21)

Hi Bastien.

> Check whether the pkcs8_key_parser kernel module is available (whether
> built-in or as a module) before announcing that we support PKCS#8.
> ---
> Changes since v2:
> - Fix comment formatting
>=20
> Changes since v1:
> - Fix missing #include
>=20
> unit/test-eapol.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)

patch has been applied, but I did fix a few whitespaces that I missed =
for some reason when looking at it in my inbox.

Regards

Marcel

