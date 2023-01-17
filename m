Received: from out-128.mta0.migadu.com (out-128.mta0.migadu.com [91.218.175.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0F3D53F
	for <iwd@lists.linux.dev>; Tue, 17 Jan 2023 20:23:24 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=boula.in; s=key1;
	t=1673986996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2EI40R1vK6/ACyhyE6UKooMXu+Hkb01zqJl7D69sIs8=;
	b=QZG7TGB4hTjF8FzZ+CNMN14OCtfJFCvtDZS6SLvUY1tmt8OluezdzPqMYs/tqpr+g6U/K2
	uP+Ik6ATwf1WDCfc+LYOkTlobRsR2CJ225/1tJ6CrirMaWIPrHVWkDksu/ilmuL2jxMGu5
	I0Xi4AZ7IT/sQi35X7iTEDvx6JrAuT+RtuOaz5Z1Ceydkw6TM/N3pUzYYWD3Yy6BCfqejc
	cGZbsDqrNtmXVH9qPRFQX6YVHkZpOmascCEpOX0Kzwad+H9+1IR4jplr9c2JMnPzJwWkJL
	NtetPmvr7sQGQFiitvPS7j6AyBFxu5ikg4mij9teA6Sixy29ucph1f/BYn1MWw==
From: Kevin Boulain <kevin@boula.in>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: iwd fails to create device
References: <2fec88f46974c051e5b4c277b50d2ae88c2fe5e5.camel@gmail.com>
	<20230115155302.14317-1-kevin@boula.in>
	<37fe77f33fe8eed72edde3e1d5ce1ca3509dc63d.camel@gmail.com>
Date: Tue, 17 Jan 2023 21:23:10 +0100
In-Reply-To: <37fe77f33fe8eed72edde3e1d5ce1ca3509dc63d.camel@gmail.com> (James
	Prestwood's message of "Tue, 17 Jan 2023 10:30:29 -0800")
Message-ID: <87pmbc29n5.fsf@boula.in>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hey James,

On 2023-01-17 at 10:30 -08, James Prestwood <prestwoj@gmail.com> wrote:
> Would you be able to try the last two patches on the list? The archive
> link is:
>
> https://lore.kernel.org/iwd/20230117180343.1451626-1-prestwoj@gmail.com/T/#t

I'd say the results are pretty conclusive:
 - without the patches the issue appeared in 3 boots of 5,
 - with the patches I didn't encounter the issue after 10 boots.

Thanks!
