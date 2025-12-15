Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65831ED9D
	for <iwd@lists.linux.dev>; Mon, 15 Dec 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790338; cv=none; b=tea2Ak04DUhvlzZ+8Zy9IFV6bHh2ggj7FBDZAKOwd3pJEnFqZtul0uJi8/N6gTsbbpAe+1j3MBCzrOToCUrJZMrb4SSrPlfjajq7XWOkXpNgOjDGYzA/+Ff3hL89vQL+4Br9Ewvg0ha9PfT31ocx76RQNoFqwJ7nle7AFTTSbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790338; c=relaxed/simple;
	bh=ictj5iRiCtPzUAewEuefhRS6Mb6dWIURctEHPUSitWY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To; b=akvXOatXqcQL6gLbccn38T/JFqkNRP+NMicRgMaUGchPGUm5RigbGBJ8vR3w66A7oeO/TtOqmmGgaR0ygcdWMKTjgbT23+7Ot6M5+diSOiOjHuDFvMyiu34UIfvJhIYrB/X4dR72W0vMinqWqq9FkRF1o8huuLE6OMRyKtpEui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=sFbhkP6s; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="sFbhkP6s"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1765790332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ictj5iRiCtPzUAewEuefhRS6Mb6dWIURctEHPUSitWY=;
	b=sFbhkP6sn8bjJGctOrZ9z/96SX85TsIH4VyPnXg651Sbd7mC2Qt/qmRCpIVcZ5wgavnWxO
	/HXmAkRGiQT25UVQ0Mw0H5etSAAgsSwivIoGUc/zGErgILPCH2EuxjCWMvaKH+Tk+0UyVO
	3YpFEAbPyJYk6Ut0OMITza9kXzuwAXg=
Date: Mon, 15 Dec 2025 09:18:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <a0121c7c60a6485d24b79f5313fd1e481c3ced55@rjp.ie>
TLS-Required: No
Subject: 6GHz only?
To: iwd@lists.linux.dev
X-Migadu-Flow: FLOW_OUT

Hi iwd,

If I disable both 2.4GHz and 5GHz bands with the BandModifier settings, I=
 get
the following error:

=C2=A0 "At least 2.4GHz and 5GHz bands must be enabled for IWD to start, =
check [Rank].BandModifier* setting"

Is there a reason one of 2.4GHz or 5GHz is required and I cannot chose to
connect only to a 6GHz band?

Cheers,

Ronan
