use warnings;
use strict;
 
package Jifty::Plugin::Userpic::Widget;

use base qw/Jifty::Web::Form::Field/;

=head1 NAME

Jifty::Plugin::Userpic::Widget - for displaying and uploading user picture.

=head1 METHODS

=head2 render_widget

Renders an upload form for the user picture, along side the current
image (if any)

=cut

sub render_widget {
    my $self     = shift;
    my $readonly = shift;
    my $action   = $self->action;
    $readonly = $readonly ? 1 : 0;

    if ( $self->current_value ) {
        Jifty->web->out( qq{<img src="/=/plugin/userpic/}
                . $self->action->record_class . "/"
                . $action->record->id . '/'
                . $self->name
                . qq{">} );
    }
    unless ($readonly) {
        my $field = qq!<input type="file" name="@{[ $self->input_name ]}" !;
        $field .= $self->_widget_class();
        $field .= qq!/>!;
        Jifty->web->out($field);
    }
    '';
}


=head2 render_value

Renders the image.

=cut

sub render_value {
    $_[0]->render_widget('readonly');
    return '';
}

1;
