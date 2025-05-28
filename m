Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30B288C1D
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443263; cv=none; b=jGChxSvM74lzwokrsRGtGIKYg5EPuF7qMll94Xd+OmBCHhK8SGkfnJxZw/hKxiLwNWoiTR42RIuPCeNfUbmvCAkfc2DiM4lhyUWyZy+q0zWAacaP7ou2hMtuwgJxC0k0STiLcdA4bMHFrLRPLCLw53VfPNlfMWs+G95UFbv+hOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443263; c=relaxed/simple;
	bh=+oJ1+5V00OJb/3SHBzqzFFVQbITyWHYwdjOfp8VHGd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Mm7yQvE401L8GHsqHg0fmSldL3uy++nWJhJR5Gj0egZJ5KodNHQJZVpLTMc1aYUJO+tCFE6Mz41BS76moEZPcbeeTJF2AmSyT+j+T1xF+jkz990qCS6dlDX2wCPkFhFfQtANmKHslkwxeP+6v/mnwjPW/yopxdbdf8l3fqf5YlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B9C83601EBE8A;
	Wed, 28 May 2025 16:40:54 +0200 (CEST)
Message-ID: <c3f204f1-e457-4f80-b7b7-031da065e4b0@molgen.mpg.de>
Date: Wed, 28 May 2025 16:40:54 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] auto-t: update serveral tests to work with netconfig
 refactor
To: James Prestwood <prestwoj@gmail.com>
References: <20250528142750.498252-1-prestwoj@gmail.com>
 <20250528142750.498252-3-prestwoj@gmail.com>
Content-Language: en-US
Cc: iwd@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250528142750.498252-3-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear James,


Am 28.05.25 um 16:27 schrieb James Prestwood:

[…]

Just a small typo in the summary/title: several.


Kind regards,

Paul
