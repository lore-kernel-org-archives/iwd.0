Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AFE2DE71A
	for <iwd@lists.linux.dev>; Sat, 23 Aug 2025 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960392; cv=none; b=iCrd1tp1LG5Aicz2QXP6CtsC9IHnc1k3WtVcNPRta0XKb5LfVquPsJJ4j9C/IbFuTjGt04zppgNvNJR7OerUuaMqnptemDbYMpXtr50gxNji7RQmxlngFMKN0ChYsgTHoHb3I1yXfL0G8/rRItbkm+XObsu/Bz1XGiE3lewtmOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960392; c=relaxed/simple;
	bh=jpnXWZe6QAQWnMYq8T57G2wH5V0qTSeM+9FhstnUlhI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Y7CjW603CH7sdlBWj31YUO+k1EJEiw3apeC+OTOC67AZUTrI+AtpeyXU1J+G9+Eu9vOZuwP4QqrCkyKLMyCnbCw9xl1pzooEDz29V6Zfiic32FHvljHFKUrH3BMJ42G+1Q579iMFN6AvLjLPpsVpKYrtEDOIINrnv2pKU/Cs1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org; spf=pass smtp.mailfrom=holtmann.org; arc=none smtp.client-ip=212.227.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=holtmann.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=holtmann.org
Received: from smtpclient.apple (p4ff9f066.dip0.t-ipconnect.de [79.249.240.102])
	by mail.holtmann.org (Postfix) with ESMTPSA id BB121CECC5;
	Sat, 23 Aug 2025 16:46:28 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 06/15] vendor_quirks: add two new vendor quirks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20250822195118.271122-6-prestwoj@gmail.com>
Date: Sat, 23 Aug 2025 16:46:18 +0200
Cc: iwd@lists.linux.dev
Content-Transfer-Encoding: 7bit
Message-Id: <E8A1EBD8-1747-4961-A27B-CBFE37065866@holtmann.org>
References: <20250822195118.271122-1-prestwoj@gmail.com>
 <20250822195118.271122-6-prestwoj@gmail.com>
To: James Prestwood <prestwoj@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

Hi James,

> VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST:
>  When a BSS requests a station roam it can optionally include a
>  list of BSS's that can be roamed to. IWD uses this list and only
>  scans on those frequencies. In some cases though the AP's list
>  contains very poor options and it would be better for IWD to
>  request a full neighbor report.
> 
> VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH:
>  On some Aruba APs there is a mismatch in the replay counters
>  between what is seen in scans versus authentications/associations.
>  This difference is not allowed in the spec, therefore IWD will
>  not connect. This quirk is intended to relax that check.
> ---
> src/vendor_quirks.c |  5 ++++-
> src/vendor_quirks.h | 15 +++++++++++++++
> 2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
> index ccfcb444..e005ba3b 100644
> --- a/src/vendor_quirks.c
> +++ b/src/vendor_quirks.c
> @@ -34,7 +34,10 @@ static const struct {
> uint8_t oui[3];
> uint32_t quirks;
> } quirk_db[] = {
> - { }
> + /* Cisco Meraki */
> + { { 0x00, 0x18, 0x0a }, VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST },
> + /* Hewlitt Packard, owns Aruba */
> + { { 0x00, 0x0b, 0x86 }, VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH },
> };

are you sure the name is Hewlitt ;)

Regards

Marcel

