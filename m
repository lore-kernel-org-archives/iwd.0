Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CE23D2B4
	for <iwd@lists.linux.dev>; Tue, 16 Dec 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765912081; cv=none; b=frH9eoeE4WDc0tSf/MCKMEdh+Zl5tj1jdj3wfZCxh2HtuTAf6mcvza+ci4j9k3S6sdFDMAbBl3h19N9QlK4V7BeOGnX21XxUP1UKb2NYETcN+y5P7D4BX1VqG6TIIzpgpb9pbx67lhudywH/CHh/6kydLgfSSl01RhvgHKonWoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765912081; c=relaxed/simple;
	bh=wGitl2EZXYDc83nm7t458MGlv6r4f2svx+IhKGQjGDc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bTQtyJ05z5Q8OTfBCFX7kI2wEgoOyO7ktn/2G6CD+2kSGn6h6740+YTsD1viP1VbuiOK3v0fK/d08u807heyB+qGMHX7ACVRnzTLm4I3ZW9APKG/hY5lpDOxZNWsG4s5WBcJDrkXzeL6SVfRLOT7zMNiQkcIti2xi8nHW0FJ6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=Sl3Ur+fD; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="Sl3Ur+fD"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1765912073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGitl2EZXYDc83nm7t458MGlv6r4f2svx+IhKGQjGDc=;
	b=Sl3Ur+fDFQVJS9it2divIPa2Z6ip42JCQDj6XKlobT4vmKIa54DAG52RvOKSbA0pIXVJBD
	uO5enrwqF9H9u0cCt2NfedlpLVEWb7xgkygnTePNYB3Lf7afeOdmBIA1Xf+a1/hptmP60/
	mw56pJSX0KTKWw9EH+BDWe7n9isQdBw=
Date: Tue, 16 Dec 2025 19:07:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <a617faab5535d79dc08d83f55ee2a16665688517@rjp.ie>
TLS-Required: No
Subject: Re: 6GHz only?
To: "James Prestwood" <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
In-Reply-To: <b580ecf6-2d21-4e6a-bd6f-0309f20e9488@gmail.com>
References: <a0121c7c60a6485d24b79f5313fd1e481c3ced55@rjp.ie>
 <b580ecf6-2d21-4e6a-bd6f-0309f20e9488@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi James,

Thanks for the reply.

> The original reason for this was based on the behavior of a few cards I=
 initially tested when implementing 6GHz support in IWD. The only way to =
utilize 6GHz was after scanning either 2.4/5ghz to allow the kernel to id=
entify the country it was in, thereby allowing 6GHz operation.

Oh, I see.

> This may have changed now, and admittedly this restriction was implemen=
ted based on only a few hardware samples. If there is different hardware =
that doesn't need this, or things have changed in the kernel I have no pr=
oblem removing this restrictions.
>=20
>=20Would you be able to remove this check on your side, rebuild, and tes=
t if 6GHz only operation works as you expect? I know that all the hardwar=
e I have still is what I originally tested with, so I'm pretty sure I wou=
ld get the same result as before.

Unfortunately, I quickly discovered that 6GHz is not functional at all on=
 my hardware [1] :/. I had hoped to coerce it to connect, but clearly tha=
t won't work. So you may have made the correct decision after all.

[1] https://bbs.archlinux.org/viewtopic.php?id=3D311005

Cheers,

Ronan
