Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB0218630
	for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kazlauskas.me header.i=@kazlauskas.me header.b="EteXe7S7"
Date: Sat, 14 Oct 2023 20:45:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kazlauskas.me;
	s=key1; t=1697305518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7OeVVSLxuRXDJc0vH2+j4it49WqHHLmLu3x15f6HdvQ=;
	b=EteXe7S70jKr0SHcb+wPda77TgflUPiHvxR7NmMAAq1fVARSdhU7H+qvpjXDc9cNRF5tHy
	x0FWqsM053Jlgkfy5D8inb149zx5z29uwVbZ40EVnVtzYam5lc8gPmW7Ai9IGXBx/SalRb
	DjKxjhrkqgu3kYRiCp1YpzAh7s8b1FY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Message-ID: <bwuu4ra65fpfpenytgu5a6ftjpvyury4omx7ucy65cshorqskl@5ikhebki4wnk>
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
 <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ff58310-c5ee-4694-821a-0c802cdedb89@gmail.com>
X-Migadu-Flow: FLOW_OUT

Denis Kenzior wrote:
>Hi James,
>
>>>
>>>     RSSI                  -78 dBm
>>>     AverageRSSI           -79 dBm
>>>     RxMode                802.11ax
>>>     RxMCS                 8
>>>     TxMode                802.11ax
>>>     TxMCS                 4
>>>     TxBitrate             206400 Kbit/s
>>>     RxBitrate             206500 Kbit/s
>>
>>This is probably because IWD doesn't take into account any of the 
>>newer 802.11ax IEs when estimating the data rate. So its estimation 
>>is based on VHT and not the newest EHT rates.
>
>We should support HE rates just fine.  Just look at the unit tests in 
>test-band.c.  Probably need an iwmon log of the AP IEs and local 
>capabilities to see why the estimate is lower than what happens in 
>practice.
>
>What hardware is being used here?

Intel’s AX201 on the client side and Ubiquiti’s U6-Pro are the AP(s).

Thank you for pointing me at iwmon, I’ll fiddle with it :)

>
>Regards,
>-Denis
