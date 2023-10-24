Received: from out-203.mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8C34CF7
	for <iwd@lists.linux.dev>; Tue, 24 Oct 2023 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kazlauskas.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kazlauskas.me header.i=@kazlauskas.me header.b="qLPtp0ep"
Date: Tue, 24 Oct 2023 18:19:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kazlauskas.me;
	s=key1; t=1698160766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj9COhedOxQcAu8iqjavT7cSt5EWeBq/G0vuAIOPYR4=;
	b=qLPtp0epeefoVtXsNewd6RJzDouy8ynKlj+fBb03oC/y+Sd0umwMC+miGCwh59lsibrTVK
	shk06ROvsel99GVMTMnrUbWz9735yJ45DqQ2pULfqeChsbgogDY8/bgMbvshndVi8rpuA3
	hlSY+Ccr/+ZU3FKTwdVHhEMJkl3YJEs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Simonas Kazlauskas <iwd.lists.linux.dev@kazlauskas.me>
To: Denis Kenzior <denkenz@gmail.com>
Cc: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
Subject: Re: Is the data rate estimation for 5GHz channels overly pessimistic?
Message-ID: <oo6afd4ygkvv47vthzqlvklqnm3gecjkkvhttrxlrmrqqb643t@6dzpfsigq6j6>
References: <05aedfe6-82ad-4e41-a9fa-e9f8a5619947@gmail.com>
 <tkizdohkwpz4nfgjczdzltr7qhvjtcyyk6x3543dht2gmm7ssc@q7m4rq3r3sqx>
 <f7ced477-6fa4-4efd-bf54-817b100041ef@gmail.com>
 <ccb68e07-e4a0-4e50-b7e2-2a2044d38487@gmail.com>
 <30b6dad4-64b2-41ca-8712-053cb1396eaf@gmail.com>
 <ncmtsi42vkdimzxsuktgfblp66agskivhuntdjlooyp7gglhgo@kwuxknllo527>
 <sebayhpora5e5ispmp5nnjesihoewc74ohygd3orxp7k22ky4c@tt225sdpjrxm>
 <29094eca-dcf8-4234-8afc-13d37db8450c@gmail.com>
 <9e12bf94-aa83-4fe6-b045-8dab45b264ae@gmail.com>
 <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d2c3d76-e08c-4d71-8a72-7193dd51cbfc@gmail.com>
X-Migadu-Flow: FLOW_OUT

Denis Kenzior wrote:
>On 10/24/23 07:32, James Prestwood wrote:
>>So you could set:
>>[Rank].LowSignalRateThreshold=-90
>>
>>Any RSSI between -82 and -90 would use -82 for the rank calculation. 
>>No idea how this would play out in practice, but its at least simple 
>>and not tied to any given hardware.
>
>No, I was more thinking about:
>/* Added to the rssi value prior to looking up in the ht_vht_he_base_rssi */
>SensitivityFudgeFactor=4
>/* Width penalty */
>SensitivityWidthPenalty=0 (3 today)
>/* NSS penalty */
>SensitivityNSSPenalty=3
>/* Same as SensitivityFudgeFactor, but for HE */
>SensitivityHEFudgeFactor=10

My main worry then would be finding good defaults for these values. Ultimately, 
unless `iwd` ends up in a place where people install it and get a great 
experience in anything that involves ranking (roaming, initial association, 
etc.), the WiFi experience on Linux may have a hard time shaking off its stigma. 
If many has to modify some config variables to get a good experience, the 
experience will continue staying subpar for the large majority still. Although 
having the knobs will at least enable a minority to extract a reasonably good 
experience.

What worries me in parituclar here is that if we tune these defaults too high 
(i.e. estimate rate better than it might end up being in practice) then we might 
end up associating with the AP that is too far away/weak to provide a 
serviceable connection.

I wonder if there’s any place in here for some dynamic component that would 
monitor how the NSS, MCS and other bandwidth affecting parameters behave for a 
given SSID/BSSID/etc. as the RSSI varies, and transparently learn these 
parameters throughout a… session (is that a term?) That way even if the 
estimation for the very first association is too pessimistic, `iwd` can do 
better when it needs to estimate again for e.g. a romaing decision or a new 
association after a sleep.

With such a scheme in place “training” IWD would also be pretty easy to explain 
to the users (walk around the area with your device connected to the network) if 
they encountered problems with a particular AP.

S.
