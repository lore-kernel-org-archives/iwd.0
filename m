Received: from stacey.r0tty.org (stacey.r0tty.org [135.181.93.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7469E3FD145
	for <iwd@lists.linux.dev>; Mon,  2 Mar 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.93.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461269; cv=none; b=ZkOqwx4njKZnsshRsApPqwirgTQYW8hVqEUrtHDrGmkfbTGti+X+dWjOQT76/pNwtkP3XmMTufFbcjXmEqtFtjN898zPzWG59pm9xRoSh6JjNP4f57oeTg7ertTChsxHIZwKDGarVqofFxyTdy0MAYRf99eixtGmcuMmvGneHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461269; c=relaxed/simple;
	bh=vF3Uqy1H7yXy3tYnS/v8VR7JoqvWxMzixTxwwmaIPyc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7LZuWGaLsqNsHUtgd9x8FyGSX7u5Y7EBv9u6Jleii5u0ukN8V0ICTtGkxbVNG0yDjlXEgDsWvSs4mL1wBg/HhA76tLpCTPViT6L3D5DuMfIkqX6u+K7/n0EJuzMqONsEqVPYKuuSBYmanQke5kKkdTqct3z5vca8woVAQIEmqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xx.vu; spf=pass smtp.mailfrom=xx.vu; dkim=pass (1024-bit key) header.d=xx.vu header.i=@xx.vu header.b=iN6uXgjn; arc=none smtp.client-ip=135.181.93.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xx.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xx.vu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xx.vu header.i=@xx.vu header.b="iN6uXgjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xx.vu; s=20200309;
	t=1772461256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G9gXDS0PoZQfu7pVxwvbtHHKRKOFT/LI0UKaxLVseEc=;
	b=iN6uXgjniZiyxcQ8oM3p/cGZ2ZTwLeqxesZx581DAHP4YwGKQJAZMzCWFHvNTsEoY+M14Q
	pOOE1BLaBcZXZm7lPywWGvYCYCyKoRNU9se6Ych5sIMtgqImSlPwq3gnMImT8+wHt6i6WB
	CDEOBvAFO7nDz/BYNd9OVnObBpYBf+A=
Received: from stacey.r0tty.org (localhost [127.0.0.1])
	by stacey.r0tty.org (OpenSMTPD) with SMTP id eb347bc5
	for <iwd@lists.linux.dev>;
	Mon, 2 Mar 2026 14:20:56 +0000 (UTC)
Date: Mon, 2 Mar 2026 14:20:56 +0000
From: Alexander Huemer <alexander.huemer@xx.vu>
To: iwd@lists.linux.dev
Subject: Re: iwd not honoring AutoConnect=false
Message-ID: <3cn36gcnqnqvraluesq3tuw2rtmtg554dac7oxopofhmuig3zi@45jbdmaujces>
Mail-Followup-To: iwd@lists.linux.dev
References: <3p56uq4uboudnyuit6hlc3d4jvfllv3y7gjyor72vokio2msmy@xpfpjfqdknj7>
 <9acd2b81-5459-483a-a959-b33600d4f733@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9acd2b81-5459-483a-a959-b33600d4f733@gmail.com>

On Thu, Feb 26, 2026 at 08:22:41PM -0600, Denis Kenzior wrote:
> On 2/26/26 4:12 AM, Alexander Huemer wrote:
> > I am using iwd 3.8 with systemd-networkd 257.9 on Debian stable (trixie)
> > on an amd64 machine.
> > There is a wireless network with a PreSharedKey with a .conf file in
> > /etc/iwd that I do not want iwd to connect to automatically if the
> > signal strength becomes better than an alternative.
> > The manpage iwd.network advises to use
> 
> You talk about iwd.network manpage, but also about /etc/iwd.  Note that iwd
> network configuration details are typically stored in /var/lib/iwd.  The
> manpage mentions this explicitly.

Yes, that was the relevant clue.
What I found in /etc were leftovers from an attempt to migrate network 
definitions from a different wireless network manager.
After putting the option in the correct file in /var/lib/iwd I got the 
expected behavior.

Thanks,
-Alex
