Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017AC2D9
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 15:17:18 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4QrlYk3bzKz9tpV;
	Wed, 28 Jun 2023 17:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tavla.de; s=MBO0001;
	t=1687965434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l34u8WHnBmpk1QGnEx60ey9hCx+rgb2lbqp65RddOcc=;
	b=ZJc14lopbyxYhlyPr70NFhdbUS9jc7YAnNP3YT+1huTLKWnzIKV9FP7zeJk3MaanxPw+bF
	4qWTe59lWO8r4Ee6lPXx+PutiqZyz2dnps2dlCfHW2Yjyok+wooD4UmZyM14RAM/RC+mDo
	ZjzXsZwSYrKD3ADF2em+8bnzRsPJnwE4B+mQYox7qaS9vJCtDXuBy93ILtFXJcn1/Hs3l+
	63T8Bz05DwDpBk3fM8Nen079FhUlXa13HFeNMLX1yP5Pw5PJCAVDaGWmBpcDxMEx81ZlsX
	0itzZa6k5auqVfSYfstTvcXSEFp5h60weld97tx3UHguNywQE4vh2uELZeUn3A==
Message-ID: <d2d75c80-a10a-67fd-07d3-3706bd008881@tavla.de>
Date: Wed, 28 Jun 2023 17:17:12 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: iwd forgets network
Content-Language: en-GB
To: Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Cc: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
 <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
 <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
 <2f0cc99c-c547-1150-d667-8fd667be86ae@gmail.com>
 <5448805b-253d-eeb6-33f2-881eb8be2157@tavla.de>
 <303737c5-0191-378f-d164-5434ed0e3c40@gmail.com>
From: Martin Petzold <martin.petzold@tavla.de>
Organization: TAVLA Technology GmbH
In-Reply-To: <303737c5-0191-378f-d164-5434ed0e3c40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 28.06.23 um 17:07 schrieb Denis Kenzior:
> Hi Martin,
>
>> Unfortunately rename is not atomic across partitions. We have our own 
>> cache implementation and hat such issues with separate tmp partition 
>> - had to switch to same partition for temporary files as the storage.
>>
>
> The temporary file is created in the same directory, side-by-side with 
> the final path.  See
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/storage.c#n132 
>
>
>
>> Still, it does not actually explain my issue.
>
> Are you mounting ext4 filesystem with non-default options by any 
> chance?  We follow advice given in [0], refer to the "Rename, fsync, 
> and ponies" section. Still, things may have changed since then.

Nothing special. And also, this is not about power-loss. I cannot 
remember this happened after a power-loss. I can only remember that we 
did a reset of the router which the device was connected.

Thanks,

Martin

