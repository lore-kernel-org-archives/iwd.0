Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC873241E1
	for <iwd@lists.linux.dev>; Sat, 14 Oct 2023 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kazlauskas.me header.i=@kazlauskas.me header.b="MnygomJG"
Date: Sat, 14 Oct 2023 20:42:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kazlauskas.me;
	s=key1; t=1697305335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EdP21xhrej7udxC7BYbq1qFUrHdJqw2chl04KoXkg8=;
	b=MnygomJG1GyvJfr3UfIrM42fhYJjAHKc0I6HdulAUvCRxPtvv4Q34YHFDptFUpfBhcme9H
	n6Xg5zJJh34iSBr3/ej4NXgw6r4s05q8ajHEdG5BTqPJX25fHFcOEOa5PjddZhTvNydB41
	qBdKLENABnOGDMMZPbZvywCmmW/iJws=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Message-ID: <bg4jb3gdt6xwuqxc2y2sbnaqs3ruh4mvavml5njyi66dvgsx7j@du4n43ujxerb>
References: <xxpypqwyk3gjrwjmpuvxqdlipkrb3fbw7augfey5ovr3lgbgul@2tbf6xw2uo3z>
 <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5780e1b2-8956-46bb-8116-b513cc564cea@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hey,

James Prestwood wrote:
>Hi Simonas,
>
>The signal strength for the 5GHz BSS's are very low. Anything below -80dbm is 
>_really_ bad. So it makes sense why IWD is choosing 2.4GHz instead. IWD's 
>estimation is based on data from the 802.11 spec, and capabilities advertised 
>by the APs.

The RSSI is an unfortunate combination of my walls being quite thick (and 
really good at attenuating 5GHz), the AP being right across said wall and, I 
believe, Ubiquiti’s automatic signal strength algorithm not picking the 
maximum transmit strength[^1] in order to avoid the sticky client problem.

[^1]: At the maximum allowed 20dBm transmit power the AverageRSSI is -72dBm.

Is -80dBm really that bad? In my experience even -85dBm felt quite serviceable 
in terms of speed and stability. Looking at Unifi’s own client diagnostics, I 
see that the connection to the machine in question does have an increased “TX 
Retries” metric at around 15%. But it is comparable to some other devices with 
RSSIs in the neighbourhood of -70dBm and retries still at around 13%, so I'm 
not quite sure if I should be paying much of my attention to that metric.

I unfortunately am not able to add more APs without tearing down the ceiling, 
and my experience with -80dBm really didn’t feel bad enough to justify maxing 
out the transmit power and thus incapacitating roaming elsewhere.

>Band steering should be done after authentication. APs shouldn't refuse 
>connections like that, otherwise what would be the point of having a 2.4GHz 
>network anyways if its impossible to connect to. Something else must be going 
>on here.

Got it, I’ll investigate the authentication failures further. Though any 
suggestions on what I should be looking at would be appreciated, as the only 
idea I have right now is to disable band steering and see if the 
authentication failures in the 2.4GHz band go away.

>This is probably because IWD doesn't take into account any of the newer 
>802.11ax IEs when estimating the data rate. So its estimation is based on VHT 
>and not the newest EHT rates.

Is taking into account the EHT rates something that *should* be implemented, 
or is this something that cannot be implemented (and thus this misestimation 
cannot be fixed?) I could dedicate some effort implementing this if its the 
former (though, again, any links to relevant resources or docs would be 
greatly appreciated to save me the effort looking for good ones myself, if you 
have any on hand.) If it is the latter, I would love to learn more about why 
that’s the case.

>Since the 2.4GHz BSS's are giving you such problems you could try a recently 
>added feature to disable the 2.4GHz band entirely. You can set 
>[Rank].BandModifier2_4Ghz=0.0.

Right. I don’t necessarily want to disable 2.4GHz entirely. The device in 
question is a laptop, and I use it sometimes in locations around my house 
where I don’t anticipate 5GHz channels to be a good choice at all. I could try 
fine-tuning for my experience by fiddling with these ranking modifiers, but my 
experience today isn’t *that* terrible that I wouldn’t be able to address it 
by other means.

>Also your BandModifier5Ghz setting has a typo, its using an uppercase 'H'. 
>Someone else got hit by this recently, we need to add support for both.

ACK

>Thanks,
>James

Thank you,
S.
