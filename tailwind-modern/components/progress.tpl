{*
 * Progress Component
 * Multi-step progress indicator with accessibility features
 * Shows current step, completed steps, and remaining steps
 *
 * Variables:
 * $currentStep - Current step number (1-5)
 * $stepTitles - Array of step titles (optional)
 *}

{* Default step titles if not provided *}
{if !$stepTitles}
    {assign var="stepTitles" value=[
        "Select Products",
        "Configure",
        "Choose Domain", 
        "Review Order",
        "Complete Purchase"
    ]}
{/if}

{assign var="totalSteps" value=count($stepTitles)}

<div class="w-full bg-gray-900 border border-gray-700 rounded-lg p-6 mb-8" role="navigation" aria-label="Order progress">
    {* Progress header *}
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-lg font-semibold text-white">Order Progress</h2>
        <div class="text-sm text-gray-400">
            Step {$currentStep} of {$totalSteps}
        </div>
    </div>
    
    {* Progress bar *}
    <div class="relative mb-6">
        <div class="w-full bg-gray-700 rounded-full h-2" role="progressbar" 
             aria-valuenow="{$currentStep}" 
             aria-valuemin="1" 
             aria-valuemax="{$totalSteps}"
             aria-label="Order completion progress">
            <div class="bg-gradient-to-r from-ds-green to-ds-blue h-2 rounded-full transition-all duration-500 ease-out"
                 style="width: {($currentStep / $totalSteps) * 100}%"></div>
        </div>
        <div class="absolute top-1/2 transform -translate-y-1/2 text-xs text-gray-400 mt-2">
            {math equation="round(($currentStep / $totalSteps) * 100)" assign="progressPercent"}
            {$progressPercent}% Complete
        </div>
    </div>
    
    {* Step indicators *}
    <div class="flex items-center justify-between relative">
        {* Background line connecting steps *}
        <div class="absolute top-5 left-0 w-full h-0.5 bg-gray-700 -z-10"></div>
        <div class="absolute top-5 left-0 h-0.5 bg-gradient-to-r from-ds-green to-ds-blue transition-all duration-500 ease-out -z-10"
             style="width: {if $currentStep > 1}{(($currentStep - 1) / ($totalSteps - 1)) * 100}{else}0{/if}%"></div>
        
        {foreach from=$stepTitles key=index item=title}
            {assign var="stepNumber" value=$index+1}
            {assign var="isCompleted" value=$stepNumber < $currentStep}
            {assign var="isCurrent" value=$stepNumber == $currentStep}
            {assign var="isUpcoming" value=$stepNumber > $currentStep}
            
            <div class="flex flex-col items-center relative z-10 {if $stepNumber < $totalSteps}flex-1{/if}">
                {* Step circle *}
                <div class="flex items-center justify-center w-10 h-10 rounded-full border-2 transition-all duration-300 transform
                    {if $isCompleted}
                        bg-ds-green border-ds-green text-gray-900 shadow-lg shadow-ds-green/25
                    {elseif $isCurrent}
                        bg-ds-blue border-ds-blue text-white shadow-lg shadow-ds-blue/25 scale-110
                    {else}
                        bg-gray-700 border-gray-600 text-gray-400
                    {/if}">
                    
                    {if $isCompleted}
                        {* Checkmark for completed steps *}
                        <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                        </svg>
                    {elseif $isCurrent}
                        {* Current step number with pulse animation *}
                        <span class="text-sm font-bold animate-pulse">{$stepNumber}</span>
                    {else}
                        {* Upcoming step number *}
                        <span class="text-sm font-bold">{$stepNumber}</span>
                    {/if}
                </div>
                
                {* Step label *}
                <div class="mt-3 text-center min-w-[100px] max-w-[120px]">
                    <div class="text-sm font-medium transition-colors duration-300
                        {if $isCurrent}
                            text-ds-blue
                        {elseif $isCompleted}
                            text-ds-green
                        {else}
                            text-gray-400
                        {/if}">
                        {$title}
                    </div>
                    
                    {* Status indicator *}
                    {if $isCompleted}
                        <div class="text-xs text-ds-green mt-1 flex items-center justify-center">
                            <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true">
                                <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>
                            </svg>
                            Completed
                        </div>
                    {elseif $isCurrent}
                        <div class="text-xs text-ds-blue mt-1 flex items-center justify-center">
                            <div class="w-2 h-2 bg-ds-blue rounded-full mr-1 animate-pulse"></div>
                            In Progress
                        </div>
                    {/if}
                </div>
            </div>
            
            {* Step connector (hidden on last step) *}
            {if $stepNumber < $totalSteps}
                <div class="flex-1 mx-4 hidden lg:block">
                    {* Connector is handled by the background lines above *}
                </div>
            {/if}
        {/foreach}
    </div>
    
    {* Mobile-friendly step navigation *}
    <div class="lg:hidden mt-6 pt-6 border-t border-gray-700">
        <div class="flex justify-between items-center">
            {if $currentStep > 1}
                <button type="button" 
                        onclick="history.back()" 
                        class="flex items-center space-x-2 text-sm text-gray-300 hover:text-ds-blue transition-colors duration-200"
                        aria-label="Go to previous step">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
                    </svg>
                    <span>Previous</span>
                </button>
            {else}
                <div></div>
            {/if}
            
            <div class="text-sm text-gray-400">
                {$stepTitles[$currentStep-1]}
            </div>
            
            {if $currentStep < $totalSteps}
                <div class="flex items-center space-x-2 text-sm text-gray-500">
                    <span>Next</span>
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
                    </svg>
                </div>
            {else}
                <div></div>
            {/if}
        </div>
    </div>
</div>

{* Screen reader announcements for step changes *}
<div id="step-announcer" class="sr-only" aria-live="polite" aria-atomic="true">
    You are on step {$currentStep} of {$totalSteps}: {$stepTitles[$currentStep-1]}
</div>

<script>
    // Progress component functionality
    document.addEventListener('DOMContentLoaded', function() {
        // Announce current step to screen readers after a brief delay
        setTimeout(function() {
            const announcer = document.getElementById('step-announcer');
            if (announcer) {
                // Trigger announcement by updating content
                const currentText = announcer.textContent;
                announcer.textContent = '';
                setTimeout(() => {
                    announcer.textContent = currentText;
                }, 100);
            }
        }, 1000);
        
        // Add keyboard navigation for progress steps (for demonstration)
        document.addEventListener('keydown', function(e) {
            // Allow arrow key navigation between steps in development/testing
            if (e.target.closest('[role="navigation"]') && e.target.closest('[aria-label="Order progress"]')) {
                if (e.key === 'ArrowLeft' && {$currentStep} > 1) {
                    e.preventDefault();
                    // In a real implementation, this would navigate to the previous step
                    console.log('Navigate to previous step');
                } else if (e.key === 'ArrowRight' && {$currentStep} < {$totalSteps}) {
                    e.preventDefault();
                    // In a real implementation, this would navigate to the next step
                    console.log('Navigate to next step');
                }
            }
        });
    });
</script>