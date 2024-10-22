Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0875126C05
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 20:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629094; cv=none; b=mb8HfKT2MwyJCC/70gXzJuN0R9ddtRtL+3pz3zHMNCutkYupWmSlTPbbhZROm/tkKmZuctmKO/fUse0YrZtRdq9LQTJbt2L13lSwj9aS6X1DjLrJrKBRXz+UzrY49+zvbI3mVj5uRVneTEUvqVeQN9aWJXqwiApZnpOfVm2ETbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629094; c=relaxed/simple;
	bh=ZTkQkaEBBiwpS8aWa/qlpBXuy7PH0xQRC0c9atpag2w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=Rmpvtr2UTJ62CSSRwush9wAQl1kVNZ79RKCEBYKHkRggwsXuw3D6CUHzTapzcjZ9CNxEVzpJR8+eaEWTOaBvun1ku3n9smFUnWv25UdtaM9f54hpywtvSiAysJ9Ylh9yfaivcD43GuvKfm3MRxTF+/e1Qlu9hKBobg4hecXO8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (unknown [95.90.232.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 22AEF61E5FE05
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 22:31:22 +0200 (CEST)
Message-ID: <a10efe9d-2b00-41dc-96bc-af02e7581f0c@molgen.mpg.de>
Date: Tue, 22 Oct 2024 22:31:21 +0200
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: After switching to iwd WLAN device *wlan0* not renamed to *wlp58s0*
 anymore
To: iwd@lists.linux.dev
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux folks,


I am using Debian sid/unstable with *iwd* 2.22-1.

Before switch from wpa_supplicant to iwd, my WLAN device was renamed 
from `wlan0` to `wlp58s0`.

     kernel: ath10k_pci 0000:3a:00.0 wlp58s0: renamed from wlan0

Since switch to iwd, the device name stays `wlan0` and the message is 
not there anymore. Strangely the behavior remains the same, when 
disabling iwd again, and switching back to wpa_supplicant. Does somebody 
know what I need to do to revert to the old behavior of the device 
renaming to `wlp58s0`?


Kind regards,

Paul
