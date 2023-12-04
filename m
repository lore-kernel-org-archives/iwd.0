Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0181CABB
	for <iwd@lists.linux.dev>; Mon,  4 Dec 2023 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="I7mI8+3H"
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1701683794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XIoQmZk9XIZHT2U+aSy4Sppb5g/2AJabHRBy4pK9ylw=;
	b=I7mI8+3Hl1rxIDYhhlbbATsHK05pcJlXDhYHx+oJp8STiRUrDJJwy2qVLoKMbZ46tr+x2k
	GtX6vf7MwhNexpcK066WYFD0xboXczPpEXAQqajxL0BLaXe2xq77QNezU/StBqn+KQIeTi
	3Jrl1R1U+DnRXAt2yhJBPs3nOlFTr3A=
Date: Mon, 04 Dec 2023 09:56:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <e3bb952a9c0550a945f002b1dc5c596e370d600d@rjp.ie>
TLS-Required: No
Subject: SAE password identifiers?
To: iwd@lists.linux.dev
X-Migadu-Flow: FLOW_OUT

Hi,

I was looking at WPA3 recently which includes a specification of the "WIF=
I:" URI
scheme. I was interseted in creating iwd .network configurations from the=
se URI
but afaict iwd is missing support for SAE password identifiers, which may=
 appear
in the URI. Is iwd capable of connecting to these networks? If so, how ca=
n it be
specified in the config?

Thanks,
Ronan
