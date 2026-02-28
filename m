Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF547B41D
	for <iwd@lists.linux.dev>; Sat, 28 Feb 2026 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292860; cv=none; b=cVLUpkgQVTyavJCkygdzi9nJ0EyNTpghJTn0OODGkRqZ11/nF/AVC2XorYPe8zNaNJX0qKhskQ/0kv1Uf9O5X8bi7dDleuQJCIhj/Q0dsP3pcdBnA/KEYQ2wT1y19lMDuYgZ4VX0Iv4/qi5VgmXoXIdTFQAyk9yV2hwLKaeJ9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292860; c=relaxed/simple;
	bh=kGyIhlaHBiWfkw/sKpPoXj0lV8NUGLo41Hxr6hBH5lw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=rlTuRfzMfMb3VrDnzY9DxMgMTVB/EtFRXgneMM44y+4W72eTQSVNHKcJY+jk5/PHVMvpYhaZpFpvWQLFuJLd4vQnCTniJjruZsPOpTCfWMCHp9erJgLiddKQ38VKULlJs3l9fSViqhmoJtlieoHsKYIkjzT63ov7ZuR5d6qWOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=U98Qt03P; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="U98Qt03P"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1772292854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OurS2AGRgHqCnwvi2srLVr2y6To+FQhEmAIchQ61JxY=;
	b=U98Qt03Pd3lCyZIQ/n2iHnR0RmIlk2obHBsWVFW8WJADBaK7dbVjOg5jXIh7J5ywXkV7am
	RQ5IgZ9/V8XHlYFG1F1bJex7LeMW6AMwL87Nks7iSxO42fGymIlDubdqTD+1tnH34KMJ/6
	m1HnVDx67XxecywOm3j7o2iXFBjJgN5zBqdWbhJ0mfuCKpdzSQ2eefa5RajNxmbpnw6b1l
	RAduWC5Jgmqn2jidZdzx7yZdd4Omlo+4mB0O5hGUGSWHNR3ktZ0V5FL2iJU+XB2EnpOTdz
	QeTzpQAu9IWdbW8pNaEha6uw2YjBk6/mnPRtogWxryoLEqGlopGYDkbDGNzZvQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Feb 2026 16:34:11 +0100
Message-Id: <DGQPDS5MRW5U.2M870OU746RO3@cknow-tech.com>
Subject: Re: iwd doesn't work with openresolv
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Denis Kenzior" <denkenz@gmail.com>, "iwd at lists.linux.dev"
 <iwd@lists.linux.dev>
References: <2249097a-97e0-175a-6b02-e5d6be484498@gmail.com>
In-Reply-To: <2249097a-97e0-175a-6b02-e5d6be484498@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon Jan 3, 2022 at 8:05 PM CET,  wrote:
>> [Service]
>> ReadWritePaths=3D/etc/resolv.conf.bak
>> ReadWritePaths=3D/etc/resolv.conf
>>=20
>> Others suggested another way to fix it:
>>=20
>> RuntimeDirectory=3Dresolvconf
>> ReadWritePaths=3D/etc/resolv.conf
>>=20
>> https://bugs.archlinux.org/task/67069
>>=20
>> Can src/iwd.service.in be adjusted?
>
> I think this or a similar issue has come up before.  The problem is that =
iwd=20
> supports either systemd-resolved or resolvconf.  So for systems that use=
=20
> systemd-resolved (which iwd defaults to), punching this security policy=
=20
> exception is not needed and arguably it should not be enabled by default.
>
> Perhaps as a compromise we may be able to ship service.in with these line=
s added=20
> & commented out.  Not sure if this would be of any help though.  Other id=
eas are=20
> welcome.

FWIW, this issue has come up again, but now in the Debian bug tracker:
https://bugs.debian.org/1129196

And Debian's iwd package version 3.11-2 added a patch to add the
ReadWritePaths to iwd.service.in.
https://tracker.debian.org/news/1723586/accepted-iwd-311-2-source-into-unst=
able/

I don't know what the best/correct solution is, but it seems helpful
that it's documented somewhere (service file, man page, etc) so that
different people don't run into the same issue again and again and have
to search for a solution to it.

Cheers,
  Diederik
