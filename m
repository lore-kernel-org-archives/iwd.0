Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5549620
	for <iwd@lists.linux.dev>; Fri, 26 Dec 2025 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766725387; cv=none; b=JlyspVTrHJza09lDBHMP4/dVb6/3yNgQyeXAnJvsRo4OHQdPyU9ow0HtuaLv0nJCd4icYIQeEY5DdgY6ML9qzfcILOP1BZQFy7o96fl9OBhN7pyjh22nrnpJnDt5dFq1jwKgjnsazdNqBDRYq3X0RAj0prLQdEXoUIT0a5XoAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766725387; c=relaxed/simple;
	bh=CpZx24tthONCMLZGcV7FYTBBUmAIeBNhB+MRUbqtqNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=kvp1AbrY2vG/FbUvU8bpe0TDhqHwA4cEJSuXGF/g2pbBWo8OP3J9JHhQXA3ea9jdFtq3Wn8kKml1FOL0jeLzoELbDLDTqtQZgiw2BEmYWtW8U7QtWfdSuRYFsmhUNmosVq/7o2YXCVqkt1sK6sKmSVjghANkXvRI5Kkxwg42lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.128.41.173] (unknown [103.50.105.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3E33361CC3FE2;
	Fri, 26 Dec 2025 06:02:47 +0100 (CET)
Message-ID: <113d74f9-b051-49eb-96c8-799caa1ec8c6@molgen.mpg.de>
Date: Fri, 26 Dec 2025 10:02:26 +0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wiphy: check if ht_capabilities are actually set
To: berend@deschouwer.co.za
References: <b22387f6f58e9be1af79a4585301fe64f83ced0d.camel@deschouwer.co.za>
Content-Language: en-US
Cc: iwd@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <b22387f6f58e9be1af79a4585301fe64f83ced0d.camel@deschouwer.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Berend,


Thank you for your patch.

Am 25.12.25 um 23:26 schrieb berend:
> commit 928fba083c87147603702907940d7c263e62e4dd (HEAD -> master)
> Author: Berend De Schouwer <berend@deschouwer.co.za>
> Date:   Thu Dec 25 17:31:49 2025 +0200
> 
>      wiphy: check if ht_capabilities are actually set
>      
>      Some devices set HT, but only provide HT20.  When this is true,
>      ap_validate_band_channel() will succeed with 40MHz width, but the
>      device will refuse to start an AP.

It’d be great if you documented one of those devices in the commit message.

> 
> diff --git a/src/wiphy.c b/src/wiphy.c
> index b6774f69..85e31cf1 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c

[…]

It looks like you pasted the output of `git show` into the message. That 
format is harder to apply with the git tools. Could you please resend 
with `git send-email` which uses the output of `git format-patch`.


Kind regards,

Paul
