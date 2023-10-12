Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4A12B7C
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="H9+ovyzF"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 35E1D240028
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 15:01:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697115673; bh=zhbXsSev/opxoSDpdAtabqVbWJf9CwdLDclHJe5RiPg=;
	h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Subject:
	 Message-ID:From;
	b=H9+ovyzFQUXedCB0d10iDwdAYjB3FXfWOGoPqpDukcRBYgebilkEpQHhm/b4mWhM0
	 ZVKZD75OBp2SalKQV24Q1aNWY6cZmVcwYH5QYMn0Mup6yhjyKNybvX2idedemPoZxl
	 50BbKYMfSz8wxzDbOte4m0RupYC58e/gtM3QvNFhveHMJpulO8OMg0wmj66uawxpA3
	 FbiqFa9kh6ywZSgHsVDom61rzw+buG3MK94XYwWKp0w09BlcotofSA5qEW8I0/y8IT
	 OibcgCuCOe8HKqWYb35vpPHmT5tJ0g8oJoQNU48EAzO4Fxyr7grBuCHPrDalTGBt4v
	 s9JmVd82GOUlw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S5qWr45t4z9rxM;
	Thu, 12 Oct 2023 15:01:12 +0200 (CEST)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2023 13:01:12 +0000
From: Sertonix <sertonix@posteo.net>
To: Denis Kenzior <denkenz@gmail.com>, iwd@lists.linux.dev
Subject: Re: [PATCH] test: log correct function name
In-Reply-To: <00fc724d-a222-99e4-7301-4d668d5df399@gmail.com>
References: <CVMUXBOJCCQ3.3DY5I2CD7ES6U@sert-surfa-alpine>
 <00fc724d-a222-99e4-7301-4d668d5df399@gmail.com>
Message-ID: <183aa9d058915c4ef0707eaae7dbc2a4@posteo.de>

> Looks fine to me, but I can't apply without a proper full name in the
> 'Author' tag.

Sorry for the delayed response. Here is the complete 'Author' tag:

Author: Sertonix Norson <sertonix@posteo.net>

